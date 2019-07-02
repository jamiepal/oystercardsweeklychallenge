
require 'journey'

describe Journey do
  describe '#initialize' do
    it 'initialises entry station to station_name' do
      journey = Journey.new('paddington')
      expect(journey.entry_station).to eq 'paddington'
    end
    it 'initialises exit station to nil' do
      journey = Journey.new('paddington')
      expect(journey.exit_station).to eq nil
    end
  end
  describe '#calc_fare' do
    journey = Journey.new
    journey.calc_fare
    it 'calculates the penalty or minimum fare'

end
