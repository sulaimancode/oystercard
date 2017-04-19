class Oystercard
  attr_reader :balance, :entry_station, :history
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @history = []

  end

  def top_up(amount)
    fail "Card limit of £#{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE
    @balance += amount
  end


  def in_journey?
    @entry_station != nil
  end

  def touch_in(entry_station)
    fail "Insufficient funds for journey" if balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    history << { @entry_station => exit_station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
