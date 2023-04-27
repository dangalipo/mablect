# frozen_string_literal: true

require_relative 'account_repository'
require_relative 'account'
require_relative 'transaction_processor'

def run(accounts_filename, transactions_filename)
  repo = AccountRepository.new(accounts_filename:)
  processor = TransactionProcessor.new(transactions_filename:)
  begin
    processor.process(repository: repo)
    csv_string = CSV.generate do |csv|
      repo.all.each do |account|
        csv << [account.account_number, format('%0.02f', (account.balance / 100))]
      end
    end
    File.write('output.csv', csv_string)
  rescue ArgumentError, Account::InsufficientFunds, AccountRepository::AccountNotFound => e
    puts e
  end
end

run(ARGV[0], ARGV[1]) if $PROGRAM_NAME == __FILE__
