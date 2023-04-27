# frozen_string_literal: true

class Transaction
  def initialize(from_account_number:, to_account_number:, amount:)
    @from_account_number = from_account_number
    @to_account_number = to_account_number
    @amount = amount
  end

  def process(repository:)
    from_account = repository.find(account_number: from_account_number)
    to_account = repository.find(account_number: to_account_number)

    from_account.widthdraw(amount:)
    to_account.deposit(amount:)

    repository.persist(account: from_account)
    repository.persist(account: to_account)
  end

  private

  attr_reader :from_account_number, :to_account_number, :amount
end
