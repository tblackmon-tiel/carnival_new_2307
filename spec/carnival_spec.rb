require './lib/ride'
require './lib/visitor'
require './lib/carnival'

RSpec.describe Carnival do
  before(:each) do
    @carnival1 = Carnival.new(14)
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
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

  describe "#add_ride" do
    it "adds a ride to the carnival" do
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.rides).to eq([@ride1, @ride2, @ride3])
    end
  end
end