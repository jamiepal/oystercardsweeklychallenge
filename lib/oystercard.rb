
class OysterCard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  def initialize(balance = 0)
    @balance = balance
    @journey_history = []
    @journey_log = JourneyLog.new
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
    if @journey_log.journey_list == []
      false
    else
    !@journey_log.journey_list.last.complete
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
    if @journey_log.journey_list == []
      @journey_log.create_journey(station_name)
    elsif @journey_log.journey_list.last.complete
      @journey_log.create_journey(station_name)
    else
      @journey_log.end_journey
      deduct(@journey_log.journey_list.last.calc_fare)
      raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
      @journey_log.create_journey(station_name)
    end
  end
  def check_when_touch_out(station_name)
    if @journey_log.journey_list== []
      @journey_log.create_journey(nil,station_name)
      deduct(@journey_log.journey_list.last.calc_fare)
    elsif @journey_log.journey_list.last.complete
      @journey_log.create_journey(nil, station_name)
      deduct(@journey_log.journey_list.last.calc_fare)
    else
      @journey_log.journey_list.last.exit_station = station_name
      @journey_log.end_journey
      deduct(@journey_log.journey_list.last.calc_fare)
    end
  end

end
