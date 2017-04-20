require "./lib/station"
require "./lib/journey"

class Oystercard
  attr_reader :balance, :history, :journey
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journey = Journey.new(nil)
    @history = []

  end

  def top_up(amount)
    fail "Card limit of £#{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE
    @balance += amount
  end


  def in_journey?
    @journey.entry_station != nil
  end

  def touch_in(journey)
    deduct if in_journey?
    fail "Insufficient funds for journey" if balance < MIN_FARE
    @journey = journey
  end

  def touch_out(exit_station)
    history << { entry_station: @journey.entry_station, exit_station: @journey.finish(exit_station) }
    deduct
    @journey = Journey.new(nil)
  end

  private

  def deduct
    @balance -= @journey.fare
  end

end
