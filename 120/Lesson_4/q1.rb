class BankAccount
  attr_reader :blance

  def initialize(starting_blance)
    @balance = starting_blance
  end

  def positive_balance?
    blance >=0
  end
end
