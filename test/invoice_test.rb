require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :parent, :invoice

  def setup
    data = {:id          => 1,
            :customer_id => 1,
            :merchant_id => 26,
            :status      => 'shipped',
            :created_at  => '2012-03-25 09:54:09 UTC',
            :updated_at  => '2012-03-25 09:54:09 UTC',
           }
    @parent = Minitest::Mock.new
    @invoice = Invoice.new(data, @parent)
  end

  def test_it_has_invoice_attributes
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
    assert_equal 'shipped', invoice.status
  end

  def test_that_it_parses_dates
    assert_equal '2012-03-25', invoice.created_at.to_s
    assert_equal '2012-03-25', invoice.updated_at.to_s
    assert_instance_of Date, invoice.created_at
    assert_instance_of Date, invoice.updated_at
  end

  def test_it_delegates_find_transactions_to_invoice_repo
    parent.expect(:find_transactions_from, nil, [1])
    invoice.transactions
    parent.verify
  end

  def test_it_delegates_find_invoice_items_to_invoice_repo
    parent.expect(:find_invoice_items_from, nil, [1])
    invoice.invoice_items
    parent.verify
  end

  def test_it_delegates_find_customer_to_invoice_repo
    parent.expect(:find_customer_from, nil, [1])
    invoice.customer
    parent.verify
  end

  def test_it_delegates_find_merchant_to_invoice_repo
    parent.expect(:find_merchant_from, nil, [26])
    invoice.merchant
    parent.verify
  end
end
