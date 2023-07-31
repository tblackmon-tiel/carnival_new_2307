class Visitor
  attr_reader :name,
              :height,
              :spending_money,
              :preferences,
              :total_money_spent

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.delete_prefix('$').to_i
    @preferences = []
    @total_money_spent = 0
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(height)
    @height >= height
  end

  def pay(amount)
    @spending_money -= amount
    @total_money_spent += amount
  end
end