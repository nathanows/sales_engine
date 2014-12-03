require_relative 'customer_repository'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'csv_parser'
require          'bigdecimal'

class SalesEngine
  attr_reader :customer_repository,
              :merchant_repository,
              :item_repository,
              :invoice_repository,
              :invoice_item_repository,
              :transaction_repository,
              :source

  DATA_PATH = File.expand_path('../..', __FILE__)

  def initialize(data_source = File.join(DATA_PATH,'data'))
    @source = data_source
    @customer_repository
    @merchant_repository
    @item_repository
    @invoice_repository
    @invoice_item_repository
    @transaction_repository
  end

  def startup
    @customer_repository     = CSVParser.parse('customers.csv',self,source)
    @merchant_repository     = CSVParser.parse('merchants.csv',self,source)
    @item_repository         = CSVParser.parse('items.csv',self,source)
    @invoice_repository      = CSVParser.parse('invoices.csv',self,source)
    @invoice_item_repository = CSVParser.parse('invoice_items.csv',self,source)
    @transaction_repository  = CSVParser.parse('transactions.csv',self,source)
    self
  end

  def find_items_from_merchant(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_from_merchant(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_transactions_from_invoice(id)
    transaction_repository.find_all_by_invoice_id(id)
  end

  def find_invoice_items_from_invoice(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_customer_from_invoice(id)
    customer_repository.find_by_id(id)
  end

  def find_merchant_from_invoice(id)
    merchant_repository.find_all_by_id(id)
  end

  def find_invoice_from_transaction(id)
    invoice_repository.find_by_id(id)
  end

  def find_invoice_from_invoice_item(id)
    invoice_repository.find_by_id(id)
  end

  def find_item_from_invoice_item(id)
    item_repository.find_by_id(id)
  end

  def find_invoice_items_from_item(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_merchant_from_item(id)
    merchant_repository.find_by_id(id)
  end

  def find_invoices_from_customer(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_transactions_from_customer(id)
    find_invoices_from_customer(id).map do |invoice_item|
      find_transactions_from_invoice(invoice_item.id)
    end.flatten
  end

  def successful_trans_from_customer(customer_id)
    find_transactions_from_customer(customer_id).select do |trans|
      trans.result == 'success'
    end.flatten
  end

  def merch_from_trans(trans)
    find_invoice_from_transaction(trans.invoice_id).merchant_id
  end

  def merch_succesful_from_cust(customer_id)
    successful_trans_from_customer(customer_id).map do |trans|
      find_merchant_from_invoice(merch_from_trans(trans))
    end.flatten
  end

  def merch_succesful_counts_from_cust(id)
    merch_succesful_from_cust(id).each_with_object(Hash.new(0)) do |obj, count|
      count[obj] += 1
    end.sort_by { |key, value| value }.reverse
  end

  def find_items_from_invoice(id)
    find_invoice_items_from_invoice(id).map do |invoice_item|
      find_item_from_invoice_item(invoice_item.item_id)
    end.flatten
  end

  def successful_trans_from_invoice?(id)
    if transaction_repository.find_by_invoice_id(id).nil?
      false
    else
      transaction_repository.find_all_by_invoice_id(id).any? do |trans|
        trans.result == 'success'
      end
    end
  end

  def pending_trans_from_invoice?(id)
    !successful_trans_from_invoice?(id)
  end

  def find_revenue_from_merchant(invoices)
    invoices.map { |invoice| invoice_repository.find_revenue_from(invoice) }
  end

  def find_revenue_from_invoice(invoice)
    invoice_repository.find_revenue_from(invoice)
  end

  def find_quantity_from_merchant(invoices)
    invoices.map { |invoice| invoice_repository.find_quantity_from(invoice) }
  end

  def find_quantity_from_customer(invoices)
    invoices.map { |inv| invoice_repository.find_quantity_from(inv) }
  end

  def find_revenue_from_customer(invoices)
    invoices.map { |inv| invoice_repository.find_revenue_from(inv) }
  end

  def find_favorite_merchant_from_customer(id)
    merch_succesful_counts_from_cust(id).first.first
  end

  def create_invoice(customer, merchant, status, items)
    invoice = invoice_repository.add(customer, merchant, status)
    invoice_item_repository.add(invoice, items)
    invoice
  end

  def charge_invoice(cc_num, cc_exp, result, invoice_id)
    transaction_repository.add(cc_num, cc_exp, result, invoice_id)
  end

  def find_invoice_customers(invoices)
    invoices.map do |invoice|
      find_customer_from_invoice(invoice.customer_id)
    end.flatten
  end
end
