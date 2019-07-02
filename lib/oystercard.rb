class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end
  attr_reader :balance, :entry_station

  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_name)
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
    @entry_station = station_name
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end
  private
  def deduct(amount)
    @balance -= amount
  end
end
