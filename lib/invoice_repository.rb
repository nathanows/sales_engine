require_relative 'invoice'
require_relative 'repository'
require_relative 'finders/merchant_id_finder'

class InvoiceRepository < Repository
  include MerchantIDFinder
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Invoice.new(entry) }
  end

  def find_by_customer_id(customer_id)
    find_by :customer_id, customer_id
  end

  def find_by_status(status)
    find_by :status, status
  end

  def find_all_by_customer_id(customer_id)
    find_all_by :customer_id, customer_id
  end

  def find_all_by_status(status)
    find_all_by :status, status
  end
end
