require 'station'


describe Station do
  describe '#initialize' do
    it 'specifies a station on creation' do
    station = Station.new('paddington', 1)
    expect(station.name).to eq 'paddington'
    end
    it 'specifies a zone on creation' do
    station = Station.new('paddington', 1)
    expect(station.zone).to eq 1
    end
  end


end
