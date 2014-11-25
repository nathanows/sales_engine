require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository < Repository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Invoice.new(entry) }
  end

  def find_by_id(id)
    find_by :id, id
  end

  def find_by_customer_id(customer_id)
    find_by :customer_id, customer_id
  end

  def find_by_merchant_id(merchant_id)
    find_by :merchant_id, merchant_id
  end

  def find_by_status(status)
    find_by :status, status
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

  def find_all_by_customer_id(customer_id)
    find_all_by :customer_id, customer_id
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by :merchant_id, merchant_id
  end

  def find_all_by_status(status)
    find_all_by :status, status
  end

  def find_all_by_created_at(created_at)
    find_all_by_date :created_at, created_at
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_date :updated_at, updated_at
  end
end
