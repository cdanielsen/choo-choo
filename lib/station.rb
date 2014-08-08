class Station

attr_accessor(:name, :id)

  def initialize(station_attributes)
    @name = station_attributes[:name]
    @id = station_attributes[:id]
  end

end

  # def self.all
  #   stations = []
  #   results = DB.exec("SELECT * FROM stations;")
  #   results.each do |result|
  #     station_attributes = {
  #       :id => result['id'].to_i,
  #       :name => result['name']
  #     }
  #     stations << Station.new(station_attributes)
  #   end
  #   stations
  # end
