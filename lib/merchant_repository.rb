require_relative 'merchant'
require_relative 'repository'
require_relative 'finders/name_finder'

class MerchantRepository < Repository
  include NameFinder
  attr_reader :data,
              :sales_engine

  def initialize(entries, sales_engine)
    @sales_engine = sales_engine
    @data ||= entries.map { |entry| Merchant.new(entry, self) }
  end

  def find_items_from(id)
    sales_engine.find_items_from_merchant(id)
  end

  def find_invoices_from(id)
    sales_engine.find_invoices_from_merchant(id)
  end

  def find_revenue_from(invoices)
    sales_engine.find_revenue_from_merchant(invoices)
  end

  def successful_trans_from_invoice?(id)
    sales_engine.successful_trans_from_invoice?(id)
  end

  def pending_trans_from_invoice?(id)
    sales_engine.pending_trans_from_invoice?(id)
  end

  def find_invoice_customers(invoices)
    sales_engine.find_invoice_customers(invoices)
  end

  def most_revenue(x)
    data.sort_by { |merchant| merchant.revenue }.reverse.first(x)
  end

  def most_items(x)
    data.sort_by { |merchant| merchant.most_quantity }.reverse.first(x)
  end

  def remove_nil_revenue(date)
    data.select {|merchant| !merchant.revenue(date).nil? }
  end

  def revenue(date)
    remove_nil_revenue(date).reduce(0) { |sum, merchant| sum + merchant.revenue(date) }
  end

  def find_quantity_from(invoices)
    sales_engine.find_quantity_from_merchant(invoices)
  end
end
