class Oystercard
attr_reader :balance, :card_limit
DEFAULT_LIMIT = 90

  def initialize
    @balance = 0
    @card_limit = DEFAULT_LIMIT
  end

  def top_up(amount)
    fail "Card limit of £#{@card_limit} exceeded" if amount + balance > @card_limit
    @balance += amount
  end

end
