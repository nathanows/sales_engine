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
end
