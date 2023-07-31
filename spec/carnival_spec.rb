require './lib/ride'
require './lib/visitor'
require './lib/carnival'

RSpec.describe Carnival do
  before(:each) do
    @carnival1 = Carnival.new(14)
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
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

  describe "#most_popular_ride" do
    it "returns the most ridden ride" do
      2.times { @ride1.board_rider(@visitor1) }
      3.times { @ride3.board_rider(@visitor3) }
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.most_popular_ride).to eq(@ride3)
    end
  end

  describe "#most_profitable_ride" do
    it "returns the ride with highest total_revenue" do
      2.times { @ride1.board_rider(@visitor1) } #2
      5.times { @ride1.board_rider(@visitor2) } #5 -> 7
      4.times { @ride3.board_rider(@visitor3) } #8
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.most_profitable_ride).to eq(@ride3)
      expect(@carnival1.most_popular_ride).to eq(@ride1)
    end
  end

  describe "#total_revenue" do
    it "returns the combined revenue of all rides" do
      2.times { @ride1.board_rider(@visitor1) }
      5.times { @ride1.board_rider(@visitor2) }
      4.times { @ride3.board_rider(@visitor3) }
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.total_revenue).to eq(15)
    end
  end

  describe "#summary" do
    xit "returns a summary hash of the carnival" do
      2.times { @ride1.board_rider(@visitor1) }
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.summary).to eq(
        {
          visitor_count: 2,
          revenue_earned: 9,
          visitors: [
            {
              visitor: @visitor1,
              favorite_ride: @ride1,
              total_money_spent: 7
            },
            {
              visitor: @visitor3,
              favorite_ride: @ride3,
              total_money_spent: 2
            }
          ],
          rides: [
            {
              ride: @ride1,
              riders: [@visitor1],
              total_revenue: 2
            },
            {
              ride: @ride2,
              riders: [@visitor1],
              total_revenue: 5
            },
            {
              ride: @ride3,
              riders: [@visitor3],
              total_revenue: 2
            }
          ]
        }
      )
    end
  end

  describe "#get_unique_visitors" do
    xit "returns an array of unique visitors" do
      2.times { @ride1.board_rider(@visitor1) }
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.get_unique_visitors).to eq([
        {
          visitor: @visitor1,
          favorite_ride: @ride1,
          total_money_spent: 7
        },
        {
          visitor: @visitor3,
          favorite_ride: @ride3,
          total_money_spent: 2
        }
      ])
    end
  end

  describe "#get_rides" do
    it "returns an array of rides with unique data" do
      2.times { @ride1.board_rider(@visitor1) }
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.get_rides).to eq([
        {
          ride: @ride1,
          riders: [@visitor1],
          total_revenue: 2
        },
        {
          ride: @ride2,
          riders: [@visitor1],
          total_revenue: 5
        },
        {
          ride: @ride3,
          riders: [@visitor3],
          total_revenue: 2
        }
      ])
    end
  end

  describe "#get_favorite_ride" do
    it "returns a visitors most ridden ride" do
      rich_visitor = Visitor.new("Richy", 64, "$100")
      rich_visitor.add_preference(:gentle)
      rich_visitor.add_preference(:thrilling)
      2.times { @ride1.board_rider(rich_visitor) }
      @ride2.board_rider(rich_visitor)
      @carnival1.add_ride(@ride1)
      @carnival1.add_ride(@ride2)
      @carnival1.add_ride(@ride3)

      expect(@carnival1.get_favorite_ride(rich_visitor)).to eq(@ride1)
    end
  end
end