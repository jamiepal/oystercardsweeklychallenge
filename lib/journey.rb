


class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_accessor :complete, :exit_station

  attr_reader :entry_station

  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    if @exit_station == nil
      @complete = false
    else
      @complete = true
    end
  end

  def calc_fare
    if !@complete
      return nil
    elsif @exit_station == nil || @entry_station == nil
      return PENALTY_FARE
    else
      return MINIMUM_FARE
    end
  end
  def finish_journey
    @complete = true
  end
end
