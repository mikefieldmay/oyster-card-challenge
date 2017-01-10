class Journey

  attr_reader :entry_station, :exit_station


  def start(entry_station)
    @entry_station = entry_station
    @complete = false
  end

  def finish(exit_station)
    @exit_station = exit_station
    @complete = true
  end

  def complete?
    @complete
  end
end
