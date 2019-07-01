class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  attr_reader :balance

  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_journey
  end
  private
  def deduct(amount)
    @balance -= amount
  end
end
