require 'pg'

class Station

attr_accessor(:name, :id)

  def initialize(station_attributes)
    @name = station_attributes[:name]
    @id = station_attributes[:id]
  end

  def self.all
    stations = []
    results = DB.exec("SELECT * FROM stations;")
    results.each do |result|
      station_attributes = {
        :id => result['id'].to_i,
        :name => result['name']
      }
      stations << Station.new(station_attributes)
    end
    stations
  end

  def save
    result = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def update(new_name)
    DB.exec("UPDATE stations SET name = '#{new_name}' WHERE id = #{self.id};")
  end

  def delete
    DB.exec("DELETE FROM stations WHERE id = #{self.id};")
  end

  def add_line(line)
    DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{line.id}, #{self.id});")
  end

  def view_lines
    lines = []
    results = DB.exec("SELECT lines.* FROM stations JOIN stops ON (stations.id = stops.station_id) JOIN lines ON (stops.line_id = lines.id) WHERE stations.id = #{self.id};")
    results.each do |result|
      line_attributes = {
        :id => result['id'].to_i,
        :name => result['name']
      }
      lines << Line.new(line_attributes)
    end
    lines
  end

  def ==(another_station)
    self.name == another_station.name
  end
end

