


class Journey

  attr_accessor :complete

  attr_reader :entry_station, :exit_station

  def initialize(station_name)
    @entry_station = station_name
    @exit_station = nil
    @fare = 0
    @complete = false
  end

end
