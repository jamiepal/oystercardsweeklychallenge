require_relative 'journey'
class JourneyLog
  def initialize(journey_class=Journey)
    @journey_class = journey_class
    @journey_list = []
  end
  attr_accessor :journey_list

  def start(entry_station, exit_station = nil)
    newjourney = @journey_class.new(entry_station, exit_station)
    @journey_list << newjourney
    newjourney
  end

  def end_journey
    @journey_list.last.finish_journey
  end

  def finish(exit_station)
    @journey_list.last.exit_station = exit_station
    @journey_list.last.finish_journey
  end

  def journeys
    @journey_list
  end

  def in_journey?
    return false if  @journey_list == []
    !@journey_list.last.complete
  end

  def calc_fare
    return 0 if @journey_list == []
    @journey_list.last.calc_fare
  end
  
  private
  def current_journey
    if !@journey_list.last.complete
      @journey_list.last
    else
      var = start(nil)
      var
    end
  end

end
