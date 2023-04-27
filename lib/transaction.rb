# frozen_string_literal: true

class Transaction
  def initialize(from_account_number:, to_account_number:, amount:)
    @from_account_number = from_account_number
    @to_account_number = to_account_number
    @amount = amount
  end

  def process(repository:)
    from_account = repository.find(from_account_number)
    to_account = repository.find(to_account_number)

    from_account.widthdraw(amount)
    to_account.deposit(amount)

    repository.persist(from_account)
    repository.persist(to_account)
  end

  private

  attr_reader :from_account_number, :to_account_number, :amount
end
