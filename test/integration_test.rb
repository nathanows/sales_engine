require_relative 'test_helper'
require_relative '../lib/sales_engine'

class IntegrationTest < Minitest::Test
  @@sales_engine = SalesEngine.new(File.join(SalesEngine::DATA_PATH, 'fixtures')).startup

  def test_a_merchant_can_have_items_returned
    merchant = @@sales_engine.merchant_repository.data.first
    assert_equal 15, merchant.items.length
  end

  def test_a_merchant_can_have_invoices_returned
    merchant = @@sales_engine.merchant_repository.data.first
    assert_equal 1, merchant.invoices.length
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
    assert_instance_of Customer, invoice.customer
  end

  def test_an_invoice_can_have_its_merchant_returned
    invoice = @@sales_engine.invoice_repository.data.first
    assert_equal 1, invoice.merchant.length
  end

  def test_a_transaction_can_have_its_invoice_returned
    transaction = @@sales_engine.transaction_repository.data.first
    assert_instance_of Invoice, transaction.invoice
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
    item = @@sales_engine.item_repository.find_by_id 1
    assert_equal 2, item.invoice_items.length
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
    invoice = @@sales_engine.invoice_repository.find_by_id 19
    assert_instance_of Item, invoice.items.first
    assert_equal 3, invoice.items.length
  end

  def test_merchant_finds_successful_invoices
    all_charges = @@sales_engine.merchant_repository.find_invoices_from(1)
    assert_equal 1, all_charges.length

    merchant_charged = @@sales_engine.merchant_repository.data.first
    assert_equal 1, merchant_charged.successful_invoices.length
  end

  def test_merchant_finds_revenue
    merchant = @@sales_engine.merchant_repository.find_by_name("Dicki-Bednar")

    assert_equal BigDecimal.new('24742.51'), merchant.revenue
  end

  def test_merchant_finds_revenue_by_date
    merchant = @@sales_engine.merchant_repository.find_by_id 4
    date = Date.parse("2012-03-27")

    assert_equal BigDecimal.new("1291.44"), merchant.revenue(date)
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
    item = @@sales_engine.item_repository.find_by_id 1
    date = item.best_day
    assert_instance_of Date, date
    assert_equal Date.new(2012, 3, 19), date
  end

  def test_customer_can_find_transactions
    customer = @@sales_engine.customer_repository.find_by_id 2
    transactions = customer.transactions
    assert_instance_of Transaction, transactions.first
    assert_equal 1, transactions.length
  end

  def test_a_customer_can_find_its_favorite_merchant
    customer = @@sales_engine.customer_repository.find_by_id 13
    favorite_merch = customer.favorite_merchant
    assert_instance_of Merchant, favorite_merch
    assert_equal "Kirlin, Jakubowski and Smitham", favorite_merch.name
  end

  def test_you_can_create_new_invoices
    customer = @@sales_engine.customer_repository.find_by_id 7
    merchant = @@sales_engine.merchant_repository.find_by_id 22
    items    = [@@sales_engine.item_repository.find_by_id(15),
                @@sales_engine.item_repository.find_by_id(15),
                @@sales_engine.item_repository.find_by_id(16)
                                                              ]

    starter_length = @@sales_engine.invoice_item_repository.data.length

    invoice  = @@sales_engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)

    assert_equal merchant.id, invoice.merchant_id
    assert_equal customer.id, invoice.customer_id
    assert_equal starter_length + 2, @@sales_engine.invoice_item_repository.data.length
  end

  def test_you_can_charge_an_invoice
    invoice = @@sales_engine.invoice_repository.find_by_id 3
    prior_trans_count = invoice.transactions.count

    invoice.charge(credit_card_number: '1111222233334444',
                   credit_card_expiration_date: '10/14',
                   result: 'success')

    invoice = @@sales_engine.invoice_repository.find_by_id invoice.id
    assert_equal prior_trans_count.next, invoice.transactions.count
  end

  def test_you_can_find_favorite_customer_from_merchant
    merchant = @@sales_engine.merchant_repository.find_by_id 1
    assert_equal 'Parker Daugherty', merchant.favorite_customer.name
  end

  def test_merchant_finds_pending_invoices
    merchant = @@sales_engine.merchant_repository.find_by_id 5
    customers = merchant.customers_with_pending_invoices
    customers_last_name = customers.map { |customer| customer.last_name  }

    assert_equal 2, customers.count
    assert_includes(customers_last_name,'Baumbach')
  end

  def test_merchant_repo_finds_most_revenue
    most = @@sales_engine.merchant_repository.most_revenue(3)
    assert_equal "Bechtelar, Jones and Stokes", most.first.name
    assert_equal "Reynolds Inc", most.last.name
  end

  def test_merchant_repo_finds_most_items
    most = @@sales_engine.merchant_repository.most_items(5)
    assert_equal "Sipes LLC", most.first.name
    assert_equal "Zemlak, Volkman and Haley", most.last.name
  end

  def test_merchant_repo_finds_revenue_for_date
    date = Date.parse("2012-03-27")
    assert_equal BigDecimal.new("43164.97") , @@sales_engine.merchant_repository.revenue(date)
  end
end
