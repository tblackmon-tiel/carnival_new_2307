require './lib/visitor'
require './lib/ride'

RSpec.describe Ride do
  before(:each) do
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
  end

  describe "#initialize" do
    it "exists" do
      expect(@ride1).to be_a Ride
    end

    it "has a hash of details" do      
      expect(@ride1.name).to eq("Carousel")
      expect(@ride1.min_height).to eq(24)
      expect(@ride1.admission_fee).to eq(1)
      expect(@ride1.excitement).to eq(:gentle)
    end

    it "has a total revenue that starts at 0" do
      expect(@ride1.total_revenue).to eq(0)
    end
  end

  describe "#rider_log" do
    it "returns a hash of visitor objects and how many times they have ridden" do
      expect(@ride1.rider_log).to be_empty
      expect(@ride1.rider_log).to be_a Hash
    end
  end

  describe "#board_rider" do
    it "boards a visitor if their height, preferences and money allow" do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.rider_log).to eq({ @visitor1 => 2, @visitor2 => 1 })
    end

    it "does not allow boarding if the visitor doesn't prefer the excitement level" do
      @visitor3.add_preference(:thrilling)

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      expect(@ride3.rider_log).to eq({ @visitor3 => 1 })
    end

    it "does not allow boarding if the visitor is not tall enough" do
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@ride3.rider_log).to eq({ @visitor3 => 1 })
    end

    it "updates the visitors spending money" do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
    end

    it "collects revenue towards total revenue" do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.total_revenue).to eq(3)
    end
  end

end