class Carnival
  attr_reader :duration, :rides
  @@all_carnivals_rides = []

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @@all_carnivals_rides << ride
    @rides << ride
  end

  def most_popular_ride
    @rides.max do |ride1, ride2|
      ride1.times_ridden? <=> ride2.times_ridden?
    end
  end

  def most_profitable_ride
    @rides.max do |ride1, ride2|
      ride1.total_revenue <=> ride2.total_revenue
    end
  end

  def total_revenue
    @rides.sum { |ride| ride.total_revenue }
  end

  def summary
    {
      visitor_count: get_unique_visitors.length,
      revenue_earned: total_revenue,
      visitors: get_unique_visitors,
      rides: get_rides
    }
  end

  def get_rides
    @rides.map do |ride|
      {
        ride: ride,
        riders: ride.rider_log.keys,
        total_revenue: ride.total_revenue
      }
    end
  end

  def get_unique_visitors
    unique_visitors = @rides.map do |ride|
      ride.rider_log.keys
    end.flatten.uniq
    unique_visitors.map do |visitor|
      {
        visitor: visitor,
        favorite_ride: get_favorite_ride(visitor),
        total_money_spent: visitor.total_money_spent
      }
    end
  end

  def get_favorite_ride(visitor)
    @rides.max do |ride1, ride2|
      ride1.rider_log[visitor] <=> ride2.rider_log[visitor]
    end
  end

  def self.total_revenues
    @@all_carnivals_rides.sum { |ride| ride.total_revenue }
  end
end