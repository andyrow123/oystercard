class Oystercard
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{ MAX_BALANCE } exceeded" if exceeded?(amount)
    @balance = @balance + amount
  end

  def touch_in
    fail 'insufficient funds' if @balance < MIN_CHARGE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_CHARGE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance = @balance - amount
  end

  def exceeded?(amount)
    @balance + amount > MAX_BALANCE
  end

end
