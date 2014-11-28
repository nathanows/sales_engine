require_relative 'test_helper'
require_relative '../lib/sales_engine'

class IntegrationTest < Minitest::Test
  @@sales_engine = SalesEngine.new.startup

  def test_a_merchant_can_have_items_returned
    merchant = @@sales_engine.merchant_repository.data.first
    assert_equal 15, merchant.items.length
  end

  def test_a_merchant_can_have_invoices_returned
    merchant = @@sales_engine.merchant_repository.data.first
    assert_equal 59, merchant.invoices.length
  end

  def test_an_invoice_can_have_transactions_returned
    invoice = @@sales_engine.invoice_repository.data.first
    assert_equal 1, invoice.transactions.length
  end

  def test_an_invoice_can_have_invoice_items_returned
    invoice = @@sales_engine.invoice_repository.data.first
    assert_equal 8, invoice.invoice_items.length
  end

  def test_an_invoice_can_have_its_customer_returned
    invoice = @@sales_engine.invoice_repository.data.first
    assert_equal 1, invoice.customer.length
  end

  def test_an_invoice_can_have_its_merchant_returned
    invoice = @@sales_engine.invoice_repository.data.first
    assert_equal 1, invoice.merchant.length
  end

  def test_a_transaction_can_have_its_invoice_returned
    transaction = @@sales_engine.transaction_repository.data.first
    assert_equal 1, transaction.invoice.length
  end

  def test_an_invoice_item_can_have_its_invoice_returned
    invoice_item = @@sales_engine.invoice_item_repository.data.first
    assert_instance_of Invoice, invoice_item.invoice
  end

  def test_a_invoice_item_can_have_its_item_returned
    invoice_item = @@sales_engine.invoice_item_repository.data.first
    assert_instance_of Item, invoice_item.item
  end

  def test_an_item_can_have_its_invoice_items_returned
    item = @@sales_engine.item_repository.data.first
    assert_equal 24, item.invoice_items.length
  end

  def test_an_item_can_have_its_merchant_returned
    item = @@sales_engine.item_repository.data.first
    assert_instance_of Merchant, item.merchant
  end
end
