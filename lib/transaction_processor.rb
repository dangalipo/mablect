# frozen_string_literal: true

require 'csv'
require_relative 'transaction'
class TransactionProcessor
  def initialize(transactions_filename:)
    @transactions_filename = transactions_filename
  end

  def process(repository:)
    transactions.each { |transaction| transaction.process(repository:) }
  end

  private

  attr_reader :transactions_filename

  def transactions
    @transactions ||= begin
      csv = CSV.read(transactions_filename)
      csv.map do |row|
        Transaction.new(from_account_number: row[0],
                        to_account_number: row[1],
                        amount: (row[2].to_f * 100))
      end
    end
  end
end
