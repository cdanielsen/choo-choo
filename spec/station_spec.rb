require 'spec_helper'

describe Station do
  describe "initialize" do
    it "creates a new station object" do
      new_station = Station.new({:name => "Everton 'pon the pond"})
      expect(new_station).to be_a Station
      expect(new_station.name).to eq "Everton 'pon the pond"
    end
  end
end
