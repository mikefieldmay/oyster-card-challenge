
class Oystercard

  attr_reader :balance

  DEFAULT_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise "Cannot top up above £#{DEFAULT_LIMIT}" if (balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

end
