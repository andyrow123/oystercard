require './lib/station.rb'

describe Station do
  subject { described_class.new(name: 'Old Street', zone: 1) }

  context 'instance vars' do
    it 'knows it\'s name' do
      expect(subject.name).to eq 'Old Street'
    end

    it 'knows it\'s zone' do
      expect(subject.zone).to eq 1
    end
  end
end