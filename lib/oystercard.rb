class Oystercard
  def initialize(balance = 0)
    @balance = balance
  end
  attr_reader :balance
  def top_up(amount)
    @balance += amount
  end
end
