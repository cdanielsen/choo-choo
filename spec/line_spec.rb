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
end
