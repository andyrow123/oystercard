class Oystercard
  attr_reader :balance

  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{ MAX_BALANCE } exceeded" if @balance + amount > MAX_BALANCE
    @balance = @balance + amount
  end

  def deduct(amount)
    @balance = @balance - amount
  end
end