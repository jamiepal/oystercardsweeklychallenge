class Oystercard
  MAXIMUM_BALANCE = 90
  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  attr_reader :balance
  
  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end
end
