class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log

  def initialize(ride_details)
    @name = ride_details[:name]
    @min_height = ride_details[:min_height]
    @admission_fee = ride_details[:admission_fee]
    @excitement = ride_details[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    # this conditional got long - any better syntax?
    if visitor.preferences.include?(@excitement) &&
    visitor.tall_enough?(@min_height) &&
    visitor.spending_money >= @admission_fee
      @rider_log[visitor] += 1
      visitor.pay(@admission_fee)
      @total_revenue += @admission_fee
    end
  end
end