# frozen_string_literal: true

require_relative '../../lib/account_repository'

RSpec.describe AccountRepository do
  let(:account_filename) { 'spec/fixtures/mable_acc_balance.csv' }
  let(:repo) { described_class.new(accounts_filename: account_filename) }

  describe '#all' do
    subject(:all) { repo.all }

    specify { expect(all.first.account_number).to eq('1111234522226789') }
    specify { expect(all.first.balance).to eq(500_000) }
    specify { expect(all.last.account_number).to eq('3212343433335755') }
    specify { expect(all.last.balance).to eq(5_000_000) }
  end

  describe '#find' do
    subject(:find) { repo.find(account_number) }
    context 'account exists' do
      let(:account_number) { '3212343433335755' }

      specify { expect(find.account_number).to eq(account_number) }
      specify { expect(find.balance).to eq(5_000_000) }
    end

    context "account doesn't exist" do
      let(:account_number) { "doesn't exist" }

      specify do
        expect { find }
          .to raise_error(AccountRepository::AccountNotFound, "Could not find account number #{account_number}")
      end
    end
  end
  end
end
