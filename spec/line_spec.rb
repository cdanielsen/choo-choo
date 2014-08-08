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
end
