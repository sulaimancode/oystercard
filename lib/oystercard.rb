class Oystercard
  attr_reader :balance, :in_use
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_use = false

  end

  def top_up(amount)
    fail "Card limit of £#{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE
    @balance += amount
  end


  def in_journey?
    @in_use
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if balance < MIN_FARE
    @in_use = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_use = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
