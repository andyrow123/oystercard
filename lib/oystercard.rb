class Oystercard
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "Maximum balance of #{ MAX_BALANCE } exceeded" if exceeded?(amount)
    @balance = @balance + amount
  end

  def touch_in(station)
    fail 'insufficient funds' if @balance < MIN_CHARGE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance = @balance - amount
  end

  def exceeded?(amount)
    @balance + amount > MAX_BALANCE
  end

end
