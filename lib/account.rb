# frozen_string_literal: true

class Account
  attr_reader :account_number, :balance

  class InsufficientFunds < StandardError; end

  def initialize(account_number:, balance:)
    @account_number = account_number
    @balance = balance
  end

  def widthdraw(amount:)
    raise ArgumentError, 'Widthdrawl amount must be positive' if amount.negative?

    new_balance = balance - amount
    if new_balance.negative?
      raise InsufficientFunds,
            "Widthdrawl of #{amount} from #{account_number} would leave account balance negative"
    else
      @balance = new_balance
    end
  end

  def deposit(amount:)
    raise ArgumentError, 'Deposit amount must be positive' if amount.negative?

    new_balance = balance + amount
    @balance = new_balance
  end
end
