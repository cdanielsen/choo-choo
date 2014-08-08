require 'pg'

class Line

attr_accessor(:name, :id)

  def initialize(line_attributes)
    @name = line_attributes[:name]
    @id = line_attributes[:id]
  end

  def self.all
    lines = []
    results = DB.exec("SELECT * FROM lines;")
    results.each do |result|
      line_attributes = {
        :id => result['id'].to_i,
        :name => result['name']
      }
      lines << Line.new(line_attributes)
    end
    lines
  end

  def save
    result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def update(new_name)
    DB.exec("UPDATE lines SET name = '#{new_name}' WHERE id = #{self.id};")
  end

  def ==(another_line)
    self.name == another_line.name
  end
end
