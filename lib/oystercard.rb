class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end
  attr_reader :balance, :entry_station, :journey_history, :exit_station

  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_name)
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
    @exit_station = nil
    @entry_station = station_name
  end

  def touch_out(station_name)
    deduct(MINIMUM_FARE)
    @exit_station = station_name
    @journey_history << {@entry_station => @exit_station}
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
