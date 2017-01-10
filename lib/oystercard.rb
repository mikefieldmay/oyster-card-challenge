
class Oystercard

  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  DEFAULT_CREDIT_LIMIT = 90
  DEFAULT_DEBIT_LIMIT = 0

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(top_up_amount)
    raise "Cannot top up above £#{DEFAULT_CREDIT_LIMIT}" if top_up_limit_reached?(top_up_amount)
    @balance += top_up_amount
  end

  def deduct(deduct_amount)
    raise "Cannot deduct below £#{DEFAULT_DEBIT_LIMIT}" if deduct_limit_reached?(deduct_amount)
    @balance -= deduct_amount
  end

  def touch_in
    raise "Touched in already" if in_journey?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def top_up_limit_reached?(top_up_amount)
    (balance + top_up_amount) > DEFAULT_CREDIT_LIMIT
  end

  def deduct_limit_reached?(deduct_amount)
    (balance - deduct_amount) < DEFAULT_DEBIT_LIMIT
  end
end
