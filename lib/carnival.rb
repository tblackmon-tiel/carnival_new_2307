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
      visitor_count: get_visitor_count,
      # revenue_earned: total_revenue,
      # visitors: get_unique_visitors,
      # rides: get_rides
    }
  end
end