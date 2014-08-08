require 'pg'

class Line

attr_reader(:name)

  def initialize(line_attributes)
    @name = line_attributes[:name]
  end
end
