# frozen_string_literal: true

require_relative '../../lib/account'

RSpec.describe Account do
  let(:account_number) { '1234' }
  let(:account) { described_class.new(account_number:, balance:) }

  describe '#widthdraw' do
    subject(:widthdraw) { account.widthdraw(amount:) }

    context 'amount is positive' do
      let(:amount) { 10 }

      context 'account has sufficient funds' do
        let(:balance) { 11 }

        specify { expect { widthdraw }.to change(account, :balance).from(balance).to(1) }
      end

      context 'account has exactly enough funds' do
        let(:balance) { 10 }

        specify { expect { widthdraw }.to change(account, :balance).from(balance).to(0) }
      end

      context "account doesn't have sufficent funds" do
        let(:balance) { 0 }

        specify do
          expect { widthdraw }
            .to raise_error(Account::InsufficientFunds,
                            "Widthdrawl of #{amount} from #{account_number} would leave account balance negative")
        end
      end
    end

    context 'amount is negative' do
      let(:balance) { 0 }
      let(:amount) { -1 }

      specify { expect { widthdraw }.to raise_error(ArgumentError, 'Widthdrawl amount must be positive') }
    end

    context 'amount is zero' do
      let(:balance) { 0 }
      let(:amount) { 0 }

      specify { expect { widthdraw }.not_to change(account, :balance) }
    end
  end

  describe '#deposit' do
    let(:amount) { 10 }
    subject(:deposit) { account.deposit(amount:) }
    let(:balance) { 11 }

    context 'amount is positive' do
      specify { expect { deposit }.to change(account, :balance).from(balance).to(21) }
    end

    context 'amount is negative' do
      let(:amount) { -1 }

      specify { expect { deposit }.to raise_error(ArgumentError, 'Deposit amount must be positive') }
    end

    context 'amount is zero' do
      let(:amount) { 0 }

      specify { expect { deposit }.not_to change(account, :balance) }
    end
  end
end
