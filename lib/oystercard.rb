
class OysterCard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  def initialize(balance = 0)
    @balance = balance
    @journey_history = []
  end
  attr_reader :balance, :journey_history

  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_name)
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
    check_circumstances(true, station_name)
  end

  def touch_out(station_name)
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < 0
    check_circumstances(false, station_name)
  end

  def in_journey?
    if @journey_history == []
      false
    else
    !@journey_history.last.complete
    end
  end
  private
  def deduct(amount)
    @balance -= amount
  end
  def check_circumstances(isittouchin, station_name)
    if isittouchin
      check_when_touch_in(station_name)
    else
      check_when_touch_out(station_name)
    end
  end
  def check_when_touch_in(station_name)
    if @journey_history == []
      @journey_history << Journey.new(station_name)
    elsif @journey_history.last.complete
      @journey_history << Journey.new(station_name)
    else
      @journey_history.last.finish_journey
      deduct(@journey_history.last.calc_fare)
      raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
      @journey_history << Journey.new(station_name)
    end
  end
  def check_when_touch_out(station_name)
    if @journey_history == []
      @journey_history << Journey.new(nil, station_name)
      deduct(@journey_history.last.calc_fare)
    elsif @journey_history.last.complete
      @journey_history << Journey.new(nil, station_name)
      deduct(@journey_history.last.calc_fare)
    else
      @journey_history.last.exit_station = station_name
      @journey_history.last.finish_journey
      deduct(@journey_history.last.calc_fare)
    end
  end

end
