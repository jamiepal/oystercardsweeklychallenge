require 'oystercard'
describe Oystercard do
  it "initialises with a default balance of 0" do
    expect(subject.balance).to eq 0
  end
  it "the balance can be topped up with top_up method" do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end
end
