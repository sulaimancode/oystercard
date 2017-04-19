class Oystercard
  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil

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

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
