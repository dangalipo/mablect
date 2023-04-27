require 'csv'
require_relative "../../lib/transaction_processor_runner"

describe "run" do
  let(:accounts_filename) { 'spec/fixtures/mable_acc_balance.csv' }
  let(:output_file) { "output.csv" }
  before do
    File.delete(output_file) if File.exist?(output_file)
  end
  subject(:run_process) { run(accounts_filename, transactions_filename) }

  context "happy path" do
    let(:transactions_filename) { 'spec/fixtures/mable_trans.csv' }
    subject(:csv) do
      run_process
      CSV.read(output_file)
    end

    specify { expect(csv[0][0]).to eq('1111234522226789') }
    specify { expect(csv[0][1]).to eq("4999.50") }
    specify { expect(csv[1][0]).to eq('3212343433335755') }
    specify { expect(csv[1][1]).to eq('50000.50') }
  end

  context "insufficient funds" do
    let(:transactions_filename) { 'spec/fixtures/mable_trans_insufficient_funds.csv' }

    specify do
      expect{run_process}
        .to output("Widthdrawl of 1000000000.0 from 1111234522226789 would leave account balance negative\n")
              .to_stdout
    end
  end

  context "negative amounts" do
    let(:transactions_filename) { 'spec/fixtures/mable_trans_negative_amounts.csv' }

    specify do
      expect{run_process}
        .to output("Widthdrawl amount must be positive\n")
              .to_stdout
    end
  end

  context "negative amounts" do
    let(:transactions_filename) { 'spec/fixtures/mable_trans_missing_account.csv' }

    specify do
      expect{run_process}
        .to output("Could not find account number 1\n")
              .to_stdout
    end
  end

  after do
    File.delete(output_file) if File.exist?(output_file)
  end
end
