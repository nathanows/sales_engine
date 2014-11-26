require_relative 'test_helper'
require_relative '../lib/sales_engine'

class IntegrationTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.new
    @sales_engine.startup
  end

  def test_a_merchant_can_have_items_returned
    merchant = sales_engine.merchant_repository.data.first
    assert_equal 15, merchant.items.length
  end
end
