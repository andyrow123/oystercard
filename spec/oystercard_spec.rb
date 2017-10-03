require './lib/oystercard'

describe Oystercard do

  context '#balance' do
    it 'should initialize with a 0 balance' do
      expect(subject.balance).to eq 0
    end
  end

  context '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add to balance' do
      expect{ subject.top_up 20 }.to change{ subject.balance }.by 20
    end

    it 'should raise error if exceeds maximum balance' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect{ subject.top_up(1) }.to raise_error "Maximum balance of #{ max_balance } exceeded"
    end
  end

  context '#deduct' do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'should deduct from balance' do
      subject.top_up(20)
      expect{ subject.deduct 20 }.to change{ subject.balance }.by -20
    end
  end
end