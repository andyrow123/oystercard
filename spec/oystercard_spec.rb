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
  end
end