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

  def test_a_customer_can_have_its_invoices_returned
    item = @@sales_engine.customer_repository.data.first
    assert_instance_of Invoice, item.invoices.first
    assert_equal 8, item.invoices.length
  end

  def test_an_invoice_can_have_its_items_returned
    invoice = @@sales_engine.invoice_repository.data.first
    assert_instance_of Item, invoice.items.first
    assert_equal 8, invoice.items.length
  end

  def test_merchant_finds_successful_invoices
    all_charges = @@sales_engine.merchant_repository.find_invoices_from(1)
    assert_equal 59, all_charges.length

    merchant_charged = @@sales_engine.merchant_repository.data.first
    assert_equal 47, merchant_charged.successful_invoices.length
  end

  def test_merchant_finds_revenue
    all_charges = @@sales_engine.merchant_repository.find_invoices_from(1)
    assert_equal 59, all_charges.length

    merchant_charged = @@sales_engine.merchant_repository.data.first
    assert_instance_of BigDecimal, merchant_charged.revenue
    assert_equal BigDecimal.new(39813247), merchant_charged.revenue
  end

  def test_merchant_finds_revenue_by_date
    all_charges = @@sales_engine.merchant_repository.find_invoices_from(1)
    assert_equal 59, all_charges.length

    merchant_charged = @@sales_engine.merchant_repository.data.first
    assert_instance_of BigDecimal, merchant_charged.revenue(Date.parse('2012-03-27'))
    assert_equal BigDecimal.new(1771651), merchant_charged.revenue(Date.parse('2012-03-27'))
  end

  def test_item_repository_finds_top_sellers
    top_5 = @@sales_engine.item_repository.most_revenue(5)
    assert_equal 5, top_5.length
    assert_instance_of Item, top_5.first
    first = top_5[0].total_revenue
    second = top_5[1].total_revenue
    last = top_5[4].total_revenue
    assert first >= second
    assert second >= last
  end

  def test_item_repository_finds_most_sold
    top = @@sales_engine.item_repository.most_items(37)
    assert_equal 37, top.length
    assert_instance_of Item, top.first
    first = top[0].number_sold
    second = top[1].number_sold
    last = top.last.number_sold
    assert first >= second
    assert second >= last
  end

  def test_item_can_find_best_date
    item = @@sales_engine.item_repository.find_by_name "Item Accusamus Ut"
    date = item.best_day
    assert_instance_of Date, date
    assert_equal Date.new(2012, 3, 18), date
  end

  def test_customer_can_find_transactions
    customer = @@sales_engine.customer_repository.find_by_id 1
    transactions = customer.transactions
    assert_instance_of Transaction, transactions.first
    assert_equal 7, transactions.length
  end

  def test_a_customer_can_find_its_favorite_merchant
    customer = @@sales_engine.customer_repository.find_by_id 13
    favorite_merch = customer.favorite_merchant
    assert_instance_of Merchant, favorite_merch
    assert_equal "Kirlin, Jakubowski and Smitham", favorite_merch.name
  end
end
