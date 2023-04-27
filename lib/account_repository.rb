# frozen_string_literal: true

require_relative 'account'
require 'csv'

class AccountRepository
  class AccountNotFound < StandardError; end

  def initialize(accounts_filename:)
    @accounts_filename = accounts_filename
  end

  def all
    stored_accounts.map do |account_number, balance|
      Account.new(account_number:, balance:)
    end
  end

  def find(account_number)
    balance = stored_accounts[account_number]
    raise AccountNotFound, "Could not find account number #{account_number}" if balance.nil?

    Account.new(account_number:, balance:)
  end
  private

  def stored_accounts
    @stored_accounts ||= begin
      csv = CSV.read(accounts_filename)
      csv.each_with_object({}) do |row, mem|
        mem[row[0]] = (row[1].to_f * 100).to_i
      end
    end
  end

  attr_reader :accounts_filename
end
