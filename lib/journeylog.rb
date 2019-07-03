class JourneyLog
  def initialize
    @journey_list = []
  end
  def create_journey(entry_station, exit_station = nil)
    exit_stat = exit_station
    @journey_list << Journey.new(entry_station,exit_station )
  end
  attr_accessor :journey_list
  def end_journey
    @journey_list.last.finish_journey
  end
end
