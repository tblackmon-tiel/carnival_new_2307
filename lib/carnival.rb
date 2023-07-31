class Carnival
  attr_reader :duration, :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
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
      # visitor_count: get_unique_visitors.length,
      # revenue_earned: total_revenue,
      # visitors: get_unique_visitors,
      # rides: get_rides
    }
  end

  def get_rides
    rides_array = []
    @rides.each do |ride|
      rides_array << {
        ride: ride,
        riders: ride.rider_log.keys,
        total_revenue: ride.total_revenue
      }
    end
    rides_array
  end

  def get_unique_visitors
    visitor_details = []
    all_visitors = []
    @rides.each do |ride|
      all_visitors << ride.rider_log.keys
    end
    unique_visitors = all_visitors.flatten.unique
    unique_visitors.each do |visitor|
      visitor_details << {
        visitor: visitor,
        # favorite_ride: get_favorite_ride(visitor),
        total_money_spent: visitor.total_money_spent
      }
    end
    visitor_details
  end

  def get_favorite_ride(visitor)
    @rides.max do |ride1, ride2|
      ride1.rider_log[visitor] <=> ride2.rider_log[visitor]
    end
  end
end