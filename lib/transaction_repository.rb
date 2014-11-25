require_relative 'transaction'
require_relative 'repository'

class TransactionRepository < Repository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Transaction.new(entry) }
  end

  def find_by_id(id)
    find_by :id, id
  end

  def find_by_invoice_id(invoice_id)
    find_by :invoice_id, invoice_id
  end

  def find_by_credit_card_number(credit_card_number)
    find_by :credit_card_number, credit_card_number
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    find_by :credit_card_expiration_date, credit_card_expiration_date
  end

  def find_by_result(result)
    find_by :result, result
  end

  def find_by_created_at(created_at)
    find_by_date :created_at, created_at
  end

  def find_by_updated_at(updated_at)
    find_by_date :updated_at, updated_at
  end

  def find_all_by_id(id)
    find_all_by :id, id
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by :invoice_id, invoice_id
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all_by :credit_card_number, credit_card_number
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    find_all_by :credit_card_expiration_date, credit_card_expiration_date
  end

  def find_all_by_result(result)
    find_all_by :result, result
  end

  def find_all_by_created_at(created_at)
    find_all_by_date :created_at, created_at
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_date :updated_at, updated_at
  end
end
