class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    raise  "Already in journey" if @complete
    @entry_station = entry_station
    @complete = false
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @complete = true
  end

  def complete?
    @complete
  end
end
