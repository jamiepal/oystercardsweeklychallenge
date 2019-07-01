require 'oystercard'
describe Oystercard do
  it "initialises with a default balance of 0" do
    expect(subject.balance).to eq 0
  end

  it "the balance can be topped up with top_up method" do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

  it "the maximum balance cannot exceed 90" do
    expect {subject.top_up(91)}.to raise_error("Error: Maximum balance is £#{Oystercard::MAXIMUM_BALANCE}")
  end

  it "the fare amount gets deducted from the total balance" do
    subject.top_up(50)
    expect(subject.deduct(3)).to eq 47
  end
end
