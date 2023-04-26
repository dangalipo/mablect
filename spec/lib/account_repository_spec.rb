# frozen_string_literal: true

require_relative '../../lib/account_repository'

RSpec.describe AccountRepository do
  describe '#all' do
    let(:account_filename) { 'spec/fixtures/mable_acc_balance.csv' }
    let(:repo) { described_class.new(accounts_filename: account_filename) }

    subject(:all) { repo.all }

    specify { expect(all.first.account_number).to eq('1111234522226789') }
    specify { expect(all.first.balance).to eq(500000) }
    specify { expect(all.last.account_number).to eq('3212343433335755') }
    specify { expect(all.last.balance).to eq(5000000) }
  end
end
