
class Oystercard

  attr_reader :balance

  DEFAULT_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise "Cannot top up above £90" if amount >= 90
    @balance += amount
  end

end
