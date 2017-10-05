require './lib/oystercard'

describe Oystercard do

  subject(:oyster_no_money) { described_class.new }
  subject(:oyster_max_balance) { described_class.new }

  before(:each) do
    oyster_max_balance.top_up(Oystercard::MAX_BALANCE)
  end

  context '#balance' do
    it 'should initialize with a 90 balance' do
      expect(oyster_no_money.balance).to eq 0
    end
  end

  context '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add to balance' do
      oyster_max_balance.touch_in
      oyster_max_balance.touch_out
      expect{ oyster_max_balance.top_up 1 }.to change{ oyster_max_balance.balance }.by 1
    end

    it 'should raise error if exceeds maximum balance' do
      expect{ oyster_max_balance.top_up(1) }.to raise_error "Maximum balance of #{ Oystercard::MAX_BALANCE } exceeded"
    end
  end

  context '#touch_in' do

    it 'can touch in' do
      oyster_max_balance.touch_in
      expect(oyster_max_balance).to be_in_journey
    end

    it 'should raise an error if touching in with no funds' do
      expect{ oyster_no_money.touch_in }.to raise_error 'insufficient funds'
    end
  end

  context '#touch_out' do
    it 'can touch out' do
      oyster_max_balance.touch_in
      oyster_max_balance.touch_out
      expect(oyster_max_balance).not_to be_in_journey
    end

    it 'should deduct from balance' do
      oyster_max_balance.touch_in
      expect{ oyster_max_balance.touch_out }.to change{ oyster_max_balance.balance }.by(-Oystercard::MIN_CHARGE)
    end
  end

  context '#in_journey?' do
    it 'is initially not in a journey' do
      expect(oyster_max_balance).not_to be_in_journey
    end

    it 'should return true or false' do
      expect(oyster_max_balance.in_journey?).to eq(true).or(eq(false))
    end
  end

end
