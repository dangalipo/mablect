# frozen_string_literal: true

require_relative '../../lib/transaction'
require_relative '../../lib/account_repository'
require_relative '../../lib/account'

RSpec.describe Transaction do
  let(:from_account_number) { '1234' }
  let(:to_account_number)   { '5678' }
  let(:amount) { 10 }
  let(:transaction) do
    described_class.new(from_account_number:,
                        to_account_number:,
                        amount:)
  end

  describe '#process' do
    let(:repo) { instance_double(AccountRepository) }
    let(:from_account) { instance_double(Account) }
    let(:to_account) { instance_double(Account) }

    subject(:process) { transaction.process(repository: repo) }

    before do
      allow(repo).to receive(:find).with(account_number: from_account_number).and_return(from_account)
      allow(repo).to receive(:find).with(account_number: to_account_number).and_return(to_account)
      allow(from_account).to receive(:widthdraw).with(amount:)
      allow(to_account).to receive(:deposit).with(amount:)
      allow(repo).to receive(:persist).with(account: from_account)
      allow(repo).to receive(:persist).with(account: to_account)
      process
    end

    specify { expect(repo).to have_received(:find).with(account_number: from_account_number) }
    specify { expect(repo).to have_received(:find).with(account_number: to_account_number) }
    specify { expect(from_account).to have_received(:widthdraw).with(amount:) }
    specify { expect(to_account).to have_received(:deposit).with(amount:) }
    specify { expect(repo).to have_received(:persist).with(account: from_account) }
    specify { expect(repo).to have_received(:persist).with(account: to_account) }
  end
end
