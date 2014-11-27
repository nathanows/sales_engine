require_relative 'customer_repository'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'csv_parser'

class SalesEngine
  attr_reader :customer_repository,
              :merchant_repository,
              :item_repository,
              :invoice_repository,
              :invoice_item_repository,
              :transaction_repository

  def initialize
    @customer_repository
    @merchant_repository
    @item_repository
    @invoice_repository
    @invoice_item_repository
    @transaction_repository
  end

  def startup
    @customer_repository     = CSVParser.parse('customers.csv', self)
    @merchant_repository     = CSVParser.parse('merchants.csv', self)
    @item_repository         = CSVParser.parse('items.csv', self)
    @invoice_repository      = CSVParser.parse('invoices.csv', self)
    @invoice_item_repository = CSVParser.parse('invoice_items.csv', self)
    @transaction_repository  = CSVParser.parse('transactions.csv', self)
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
    customer_repository.find_all_by_id(id)
  end

  def find_merchant_from_invoice(id)
    merchant_repository.find_all_by_id(id)
  end

  def find_invoice_from_transaction(id)
    invoice_repository.find_all_by_id(id)
  end
end