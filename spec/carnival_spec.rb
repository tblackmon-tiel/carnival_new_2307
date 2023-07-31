require './lib/ride'
require './lib/visitor'
require './lib/carnival'

RSpec.describe Carnival do
  describe "#initialize" do
    it "exists" do
      carnival1 = Carnival.new

      expect(carnival1).to be_a Carnival
    end
  end
end