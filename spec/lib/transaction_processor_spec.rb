# frozen_string_literal: true

require_relative '../../lib/transaction_processor'
require_relative '../../lib/account_repository'

RSpec.describe TransactionProcessor do
  let(:accounts_filename) { 'spec/fixtures/mable_acc_balance.csv' }
  let(:transactions_filename) { 'spec/fixtures/mable_trans.csv' }
  let(:repo) { AccountRepository.new(accounts_filename:) }
  let(:processor) { described_class.new(transactions_filename:) }

  subject(:accounts) do
    processor.process(repository: repo)
    repo.all
  end

  specify { expect(accounts.first.account_number).to eq('1111234522226789') }
  specify { expect(accounts.first.balance).to eq(499_950) }
  specify { expect(accounts.last.account_number).to eq('3212343433335755') }
  specify { expect(accounts.last.balance).to eq(5_000_050) }
end
