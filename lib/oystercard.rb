class Oystercard
attr_reader :balance, :card_limit, :in_use
DEFAULT_LIMIT = 90
MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @card_limit = DEFAULT_LIMIT
    @in_use = false

  end

  def top_up(amount)
    fail "Card limit of £#{@card_limit} exceeded" if amount + balance > card_limit
    @balance += amount
  end


  def in_journey?
    @in_use
  end

  def touch_in
    fail "Insufficient funds for journey" if balance < MINIMUM_FARE
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_use = false
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end

end
