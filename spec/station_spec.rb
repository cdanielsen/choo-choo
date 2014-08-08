require 'spec_helper'

describe Station do
  describe "initialize" do
    it "creates a new station object" do
      new_station = Station.new({:name => 'Everton "pon the pond'})
      expect(new_station).to be_a Station
      expect(new_station.name).to eq 'Everton "pon the pond'
    end
  end

  describe "self.all" do
    it "display all stations as an array" do
      expect(Station.all).to eq []
    end
  end

  describe "save" do
    it "saves a new station to the database" do
      new_station = Station.new({:name => 'Everton "pon the pond'})
      new_station.save
      expect(Station.all).to eq [new_station]
    end
  end

  describe "==" do
    it 'is the same station if the name is the same' do
      new_station1 = Station.new({:name => 'Everton "pon the pond'})
      new_station2 = Station.new({:name => 'Everton "pon the pond'})
      new_station1.save
      new_station2.save
      expect(new_station1).to eq new_station2
    end
  end

  describe "update" do
    it "changes the name of the station" do
      new_station = Station.new({:name => 'Everton "pon the pond'})
      new_station.save
      new_station.update('Shakespeare"s dive')
      expect(Station.all[0].name).to eq 'Shakespeare"s dive'
    end
  end

  describe "delete" do
    it "deletes a station from the database" do
      new_station = Station.new({:name => 'Everton "pon the pond'})
      new_station.save
      new_station.delete
      expect(Station.all).to eq []
    end
  end

  describe "add_line" do
    it "links a line to a station" do
      new_line = Line.new({:name => "Fancy Line"})
      new_line.save
      new_station = Station.new({:name => 'Everton "pon the pond'})
      new_station.save
      new_station.add_line(new_line)
      expect(new_station.view_lines).to eq [new_line]
    end
  end

  describe "view_lines" do
    it "shows all lines for a particular station" do
      new_line = Line.new({:name => "Fancy Line"})
      new_line.save
      new_station = Station.new({:name => 'Everton "pon the pond'})
      new_station.save
      new_station.add_line(new_line)
      expect(new_station.view_lines).to eq [new_line]
    end
  end

end
