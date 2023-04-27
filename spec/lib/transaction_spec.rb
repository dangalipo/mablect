require_relative "../../lib/transaction"
require_relative "../../lib/account_repository"
require_relative "../../lib/account"

RSpec.describe Transaction do
  let(:from_account_number) { "1234" }
  let(:to_account_number)   { "5678" }
  let(:amount) { 10 }
  let(:transaction) do
    described_class.new(from_account_number: from_account_number,
                        to_account_number: to_account_number,
                        amount: amount
                       )
  end

  describe "#process" do
    let(:repo) { instance_double(AccountRepository) }
    let(:from_account) { instance_double(Account) }
    let(:to_account) { instance_double(Account) }

    subject(:process) { transaction.process(repository: repo) }

    before do
      allow(repo).to receive(:find).with(from_account_number).and_return(from_account)
      allow(repo).to receive(:find).with(to_account_number).and_return(to_account)
      allow(from_account).to receive(:widthdraw).with(amount)
      allow(to_account).to receive(:deposit).with(amount)
      allow(repo).to receive(:persist).with(from_account)
      allow(repo).to receive(:persist).with(to_account)
      process
    end

    specify { expect(repo).to have_received(:find).with(from_account_number) }
    specify { expect(repo).to have_received(:find).with(to_account_number) }
    specify { expect(from_account).to have_received(:widthdraw).with(amount) }
    specify { expect(to_account).to have_received(:deposit).with(amount) }
    specify { expect(repo).to have_received(:persist).with(from_account) }
    specify { expect(repo).to have_received(:persist).with(to_account) }
  end
end
