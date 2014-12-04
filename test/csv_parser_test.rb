require_relative 'test_helper'
require_relative '../lib/csv_parser'
require_relative '../lib/sales_engine'

class CSVParserTest < Minitest::Test
  def test_it_can_get_a_full_production_filepath
    filepath = CSVParser.get_filepath('customers.csv', File.join(SalesEngine::DATA_PATH, 'data'))
    assert_equal File.join(File.expand_path('../..', __FILE__), 'data/customers.csv'), filepath
  end

  def test_it_can_get_a_full_test_filepath
    filepath = CSVParser.get_filepath('customers.csv', File.join(SalesEngine::DATA_PATH, 'fixtures'))
    assert_equal File.join(File.expand_path('../..', __FILE__), 'fixtures/customers.csv'), filepath
  end

  def test_it_can_load_a_customer_to_the_correct_repository
    new_obj = CSVParser.parse('customers.csv', self, File.join(SalesEngine::DATA_PATH, 'fixtures'))
    assert_instance_of CustomerRepository, new_obj
    assert_equal 51, new_obj.data.length
  end

  def test_it_can_load_invoice_items_to_the_correct_repository
    new_obj = CSVParser.parse('invoice_items.csv', self, File.join(SalesEngine::DATA_PATH, 'fixtures'))
    assert_instance_of InvoiceItemRepository, new_obj
    assert_equal 500, new_obj.data.length
  end

  def test_it_can_load_invoices_to_the_correct_repository
    new_obj = CSVParser.parse('invoices.csv', self, File.join(SalesEngine::DATA_PATH, 'fixtures'))
    assert_instance_of InvoiceRepository, new_obj
    assert_equal 100, new_obj.data.length
  end

  def test_it_can_load_items_to_the_correct_repository
    new_obj = CSVParser.parse('items.csv', self, File.join(SalesEngine::DATA_PATH, 'fixtures'))
    assert_instance_of ItemRepository, new_obj
    assert_equal 103, new_obj.data.length
  end

  def test_it_can_load_merchants_to_the_correct_repository
    new_obj = CSVParser.parse('merchants.csv', self, File.join(SalesEngine::DATA_PATH, 'fixtures'))
    assert_instance_of MerchantRepository, new_obj
    assert_equal 100, new_obj.data.length
  end

  def test_it_can_load_transactions_to_the_correct_repository
    new_obj = CSVParser.parse('transactions.csv', self, File.join(SalesEngine::DATA_PATH, 'fixtures'))
    assert_instance_of TransactionRepository, new_obj
    assert_equal 248, new_obj.data.length
  end
end
