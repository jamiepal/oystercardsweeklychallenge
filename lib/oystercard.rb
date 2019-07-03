require_relative 'journeylog'
class OysterCard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  def initialize(balance = 0,journeylog=JourneyLog.new)
    @balance = balance
    @journey_log = journeylog
  end
  attr_reader :balance, :journey_history

  def top_up(amount)
    raise "Error: Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
    check_when_touch_in( station)
  end

  def touch_out(station)
    raise "Error: insufficient funds. Balance is #{@balance}." if @balance < 0
    check_when_touch_out(station)
  end

  def in_journey?
    @journey_log.in_journey?
  end
  private
  def deduct(amount)
    @balance -= amount
  end

  def check_when_touch_in(station)
    if @journey_log.in_journey?
      @journey_log.end_journey
      deduct(@journey_log.calc_fare)
      raise "Error: insufficient funds. Balance is #{@balance}." if @balance < MINIMUM_FARE
    end
    @journey_log.start(station)
  end
  
  def check_when_touch_out(station)
    if !@journey_log.in_journey?
      @journey_log.start(nil, station)
    else
      @journey_log.finish(station)
    end
    deduct(@journey_log.calc_fare)
  end

end
