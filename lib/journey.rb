class Journey

attr_reader  :entry_station, :exit_station

MIN_FARE = 1
PENALTY_FARE = 6

def initialize(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

  def complete?
    entry_station && exit_station
  end

end

=begin
def initialize
start(nil)
finish(nil)
end

def start(entry_station)
@entry_station = entry_station
end
=end
