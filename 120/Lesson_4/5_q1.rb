class BankAccount
  #attr_reader :blance
  #attr_writer :blance

  def initialize(starting_blance)
    @balance = starting_blance
  end

  def positive_balance?
    @balance >= 0
  end
end

b = BankAccount.new(1)
puts b.positive_balance?
