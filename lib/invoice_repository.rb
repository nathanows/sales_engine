require_relative 'invoice'
require_relative 'repository'
require_relative 'finders/merchant_id_finder'

class InvoiceRepository < Repository
  include MerchantIDFinder
  attr_reader :data, :sales_engine

  def initialize(entries, sales_engine)
    @sales_engine = sales_engine
    @data ||= entries.map { |entry| Invoice.new(entry, self) }
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

  def find_transactions_from(id)
    sales_engine.find_transactions_from_invoice(id)
  end

  def find_invoice_items_from(id)
    sales_engine.find_invoice_items_from_invoice(id)
  end

  def find_customer_from(id)
    sales_engine.find_customer_from_invoice(id)
  end

  def find_merchant_from(id)
    sales_engine.find_merchant_from_invoice(id)
  end

  def find_items_from(id)
    sales_engine.find_items_from_invoice(id)
  end

  def find_revenue_from(invoice)
    find_invoice_items_from(invoice.id).inject(0) { |sum, invoice_item| sum + invoice_item.revenue }
  end
end
