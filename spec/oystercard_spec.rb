require 'oystercard'
describe Oystercard do

  describe "#initialize" do
    it "initialises with a default balance of 0" do
      expect(subject.balance).to eq 0
    end
    it "is initializes journey_history to []" do
      expect(subject.journey_history).to eq []
    end
  end
  describe "#top_up" do
    it "the balance can be topped up with top_up method" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it "the maximum balance cannot exceed 90" do
      expect {subject.top_up(91)}.to raise_error("Error: Maximum balance is £#{Oystercard::MAXIMUM_BALANCE}")
    end
  end

#  it "the fare amount gets deducted from the total balance" do
#    subject.top_up(50)
#    expect(subject.deduct(3)).to eq 47
#  end
#  describe "#in_journey" do
#    it { should_not be_in_journey } #used predicate method matcher
#  end
  describe "#touch_out" do
    it "touching out changes in_journey to false" do
      subject.top_up(2)
      subject.touch_in("waterloo")
      subject.touch_out("paddington")
      expect(subject.in_journey?).to eq false
    end
    it "deducts minimumfare from balance upon touch-out" do
      subject.top_up(2)
      subject.touch_in("waterloo")
      expect {subject.touch_out("paddington")}.to change{subject.balance}.by(-1)
    end
    it "sets entry_station to nil on touch_out" do
      subject.top_up(2)
      subject.touch_in("waterloo")
      subject.touch_out("paddington")
      expect(subject.entry_station).to eq nil
    end
    it "sets exit_station to station name in argument" do
      subject.top_up(2)
      subject.touch_in("waterloo")
      subject.touch_out("paddington")
      expect(subject.exit_station).to eq "paddington"
      end
  end
  describe "#touch_in" do
    it "touching in changes in_journey to true" do
      subject.top_up(2)
      subject.touch_in("waterloo")
      expect(subject.in_journey?).to eq true
    end
    it "remembers the entry station on touch-in" do
      subject.top_up(2)
      subject.touch_in("waterloo")
      expect(subject.entry_station).to eq "waterloo"
    end
    it "checks for minimum balance on touch in and raises error if balance is < minimum fare: #{Oystercard::MINIMUM_FARE}" do
      expect { subject.touch_in("waterloo")}.to raise_error("Error: insufficient funds. Balance is #{subject.balance}.")
    end
    it "checks for minimum balance on touch in and does not raise error if balance is >= minimum fare: #{Oystercard::MINIMUM_FARE}" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect(subject.touch_in("waterloo")).to be_a(String)
    end
  end
  describe "#journey_history" do
    it "stores a single journey of entry and exit stations" do
      subject.top_up(2)
      subject.touch_in("waterloo")
      subject.touch_out("paddington")
      expect(subject.journey_history).to eq [{"waterloo" => "paddington" }]
    end

  end

#  describe "#journey_history" do


end
