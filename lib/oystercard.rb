
class Oystercard
  MAXIMUM_BALANCE = 90
  def initialize(balance = 0)
    @balance = balance
  end

  attr_reader :balance

  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
