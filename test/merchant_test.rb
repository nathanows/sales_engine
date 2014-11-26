require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :merchant,
              :parent

  def setup
    data = { :id         => 1,
             :name       => 'Schroeder-Jerde',
             :created_at => '2012-03-27 14:53:59 UTC',
             :updated_at => '2012-03-27 14:53:59 UTC'
                                                      }
    @parent   = Minitest::Mock.new
    @merchant = Merchant.new(data, parent)
  end

  def test_that_a_merchant_has_attributes
    assert_equal 1, merchant.id
    assert_equal 'Schroeder-Jerde', merchant.name
  end

  def test_that_it_parses_dates
    assert_equal '2012-03-27', merchant.created_at.to_s
    assert_equal '2012-03-27', merchant.updated_at.to_s
    assert_instance_of Date, merchant.created_at
    assert_instance_of Date, merchant.updated_at
  end

  def test_it_delegates_find_items_to_merchant_repo
    parent.expect(:find_items_from, nil,[1] )
    merchant.items
    parent.verify
  end

  def test_it_delegates_find_invoices_to_merchant_repo
    parent.expect(:find_invoices_from, nil,[1] )
    merchant.invoices
    parent.verify
  end
end
