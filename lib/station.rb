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

  def ==(another_station)
    self.name == another_station.name
  end
end

