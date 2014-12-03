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

  def pending_trans_from_invoice?(id)
    sales_engine.pending_trans_from_invoice?(id)
  end

  def find_invoice_customers(invoices)
    sales_engine.find_invoice_customers(invoices)
  end

  def most_revenue(x)
    remove_nil_revenue.sort_by { |merchant| merchant.revenue }.reverse.first(x)
  end

  def most_items(x)
    remove_nil_items.sort_by { |merchant| merchant.most_quantity }.reverse.first(x)
  end

  def remove_nil_items
    data.select { |merchant| !merchant.most_quantity.nil? }
  end

  def remove_nil_revenue(date = nil)
    data.select {|merchant| !merchant.revenue(date).nil? }
  end

  def revenue(date)
    remove_nil_revenue(date).reduce(0) do |sum, merchant|
      sum + merchant.revenue(date)
    end
  end

  def find_quantity_from(invoices)
    sales_engine.find_quantity_from_merchant(invoices)
  end
end
