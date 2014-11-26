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
  end

  def find_items_from_merchant(id)
    item_repository.find_all_by_merchant_id(id)
  end
end
