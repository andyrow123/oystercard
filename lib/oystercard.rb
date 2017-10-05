class Oystercard
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail 'insufficient funds' if @balance < MIN_CHARGE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @exit_station = station
    save_journey
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceeded?(amount)
    @balance + amount > MAX_BALANCE
  end

  def save_journey
    @journeys.push(entry_station: @entry_station, exit_station: @exit_station)
  end
end
