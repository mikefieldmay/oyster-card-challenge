
class Oystercard

  attr_reader :balance

  DEFAULT_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(top_up_amount)
    raise "Cannot top up above £#{DEFAULT_LIMIT}" if top_up_limit_reached?(top_up_amount)
    @balance += top_up_amount
  end

  def deduct(deduct_amount)

  end

  private

  def top_up_limit_reached?(top_up_amount)
    (balance + top_up_amount) > DEFAULT_LIMIT
  end

end
