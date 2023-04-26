# frozen_string_literal: true

class Account
  attr_reader :account_number, :balance

  def initialize(account_number:, balance:)
    @account_number = account_number
    @balance = balance
  end
end
