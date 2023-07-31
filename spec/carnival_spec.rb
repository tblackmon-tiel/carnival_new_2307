require './lib/ride'
require './lib/visitor'
require './lib/carnival'

RSpec.describe Carnival do
  before(:each) do
    @carnival1 = Carnival.new(14)
  end
  describe "#initialize" do
    it "exists" do
      expect(@carnival1).to be_a Carnival
    end

    it "has a duration and a list of rides" do
      expect(@carnival1.duration).to eq(14)
      expect(@carnival1.rides).to be_a Array
      expect(@carnival1.rides).to be_empty
    end
  end
end