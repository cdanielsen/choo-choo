require 'pg'

class Line

attr_reader(:name)

  def initialize(line_attributes)
    @name = line_attributes[:name]
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

end
