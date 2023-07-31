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
    @rides.max do |a, b|
      a.times_ridden? <=> b.times_ridden?
    end
  end
end