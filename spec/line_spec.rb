require 'spec_helper'

describe Line do
  describe "initialize" do
    it "creates a new line object" do
      new_line = Line.new({:name => "Fancy Line"})
      expect(new_line).to be_a Line
      expect(new_line.name).to eq "Fancy Line"
    end
  end

  describe "self.all" do
    it "display all lines as an array" do
      expect(Line.all).to eq []
    end
  end

  describe "save" do
    it "saves a new line to the database" do
      new_line = Line.new({:name => "Fancy Line"})
      new_line.save
      expect(Line.all).to eq [new_line]
    end
  end

  describe "==" do
    it 'is the same line if the name is the same' do
      new_line1 = Line.new({:name => "Fancy Line"})
      new_line2 = Line.new({:name => "Fancy Line"})
      new_line1.save
      new_line2.save
      expect(new_line1).to eq new_line2
    end
  end

  describe "update" do
    it "changes the name of the line" do
      new_line = Line.new({:name => "Fancy Line"})
      new_line.save
      new_line.update("Rubbish Line")
      expect(Line.all[0].name).to eq "Rubbish Line"
    end
  end

  describe "delete" do
    it "deletes a line from the database" do
      new_line = Line.new({:name => "Fancy Line"})
      new_line.save
      new_line.delete
      expect(Line.all).to eq []
    end
  end

  describe "add_station" do
    it "links a station to a line" do
      new_line = Line.new({:name => "Fancy Line"})
      new_line.save
      new_station = Station.new({:name => 'Everton "pon the pond'})
      new_station.save
      new_line.add_station(new_station)
      expect(new_line.view_stations).to eq [new_station]
    end
  end

  describe "view_stations" do
    it "shows all stations on a line" do
      new_line = Line.new({:name => "Fancy Line"})
      new_line.save
      new_station = Station.new({:name => 'Everton "pon the pond'})
      new_station.save
      new_line.add_station(new_station)
      expect(new_line.view_stations).to eq [new_station]
    end
  end
end









