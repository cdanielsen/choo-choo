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
end
