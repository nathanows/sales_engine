require_relative 'invoice'
require_relative 'repository'
require_relative 'finders/merchant_id_finder'

class InvoiceRepository < Repository
  include MerchantIDFinder
  attr_reader :sales_engine
  attr_accessor :data

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
    find_revenue_from_invoice_items(invoice)
  end

  def find_revenue_from_invoice_items(invoice)
    find_invoice_items_from(invoice.id).inject(0) do |sum, invoice_item|
      sum + invoice_item.revenue
    end
  end

  def find_quantity_from(invoice)
    find_quantity_from_invoice_items(invoice)
  end

  def find_quantity_from_invoice_items(invoice)
    find_invoice_items_from(invoice.id).inject(0) do |sum, invoice_item|
      sum + invoice_item.quantity
    end
  end

  def create(options = {})
    customer = options[:customer]
    merchant = options[:merchant]
    status   = options[:status]
    items    = options[:items]
    sales_engine.create_invoice(customer, merchant, status, items)
  end

  def add(customer, merchant, status)
    new_invoice = {
      :id          => next_id,
      :customer_id => customer.id,
      :merchant_id => merchant.id,
      :status      => status,
      :created_at  => Date.today.to_s,
      :updated_at  => Date.today.to_s
    }
    self.data << Invoice.new(new_invoice, self)
    data.last
  end

  def next_id
    data.max_by { |invoice| invoice.id }.id + 1
  end
end
