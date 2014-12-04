require_relative 'customer'
require_relative 'repository'

class CustomerRepository < Repository
  attr_reader :data,
              :sales_engine

  def initialize(entries, sales_engine)
    @sales_engine = sales_engine
    @data ||= entries.map { |entry| Customer.new(entry, self) }
  end

  def find_by_first_name(first_name)
    find_by :first_name, first_name
  end

  def find_by_last_name(last_name)
    find_by :last_name, last_name
  end

  def find_all_by_first_name(first_name)
    find_all_by :first_name, first_name
  end

  def find_all_by_last_name(last_name)
    find_all_by :last_name, last_name
  end

  def find_invoices_from(id)
    sales_engine.find_invoices_from_customer(id)
  end

  def find_transactions_from(id)
    sales_engine.find_transactions_from_customer(id)
  end

  def find_favorite_merchant_from(id)
    sales_engine.find_favorite_merchant_from_customer(id)
  end

  def most_items
    remove_nil_items.sort_by {
      |customer| customer.most_quantity
    }.reverse.first
  end

  def most_revenue
    remove_nil_items.sort_by {
      |customer| customer.most_revenue
    }.reverse.first
  end

  def remove_nil_items
    data.select { |customer| !customer.most_quantity.nil? }
  end

  def find_quantity_from(invoices)
    sales_engine.find_quantity_from_customer(invoices)
  end

  def find_revenue_from(invoices)
    sales_engine.find_revenue_from_customer(invoices)
  end
end
