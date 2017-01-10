
class Oystercard

  attr_reader :balance, :in_journey, :start_station, :journeys
  #alias_method :in_journey?, :in_journey

  DEFAULT_CREDIT_LIMIT = 90
  DEFAULT_DEBIT_LIMIT = 0
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    #@start_station
    @journeys = []
  end

  def top_up(top_up_amount)
    raise "Cannot top up above £#{DEFAULT_CREDIT_LIMIT}" if top_up_limit_reached?(top_up_amount)
    @balance += top_up_amount
  end

  def touch_in(entry_station)
    raise "Touched in already" if in_journey?
    raise "Balance below minimum fare" if balance_below_minimum?
    start_journey(entry_station)
  end

  def touch_out(exit_station)
    raise "Touched out already" unless in_journey?
    journeys<<{start_station: start_station, exit_station: exit_station}
    end_journey
  end

  def in_journey?
    @start_station != nil
  end

  private

  def start_journey(entry_station)
    @in_journey = true
    @start_station = entry_station
  end

  def end_journey
    @in_journey = false
    @start_station = nil
    deduct(MINIMUM_FARE)
  end

  def balance_below_minimum?
    @balance < MINIMUM_FARE
  end

  def top_up_limit_reached?(top_up_amount)
    (balance + top_up_amount) > DEFAULT_CREDIT_LIMIT
  end

  def deduct_limit_reached?(deduct_amount)
    (balance - deduct_amount) < DEFAULT_DEBIT_LIMIT
  end

  def deduct(deduct_amount)
    raise "Cannot deduct below £#{DEFAULT_DEBIT_LIMIT}" if deduct_limit_reached?(deduct_amount)
    @balance -= deduct_amount
  end

end
