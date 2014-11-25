require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_that_a_merchant_has_attributes
    data = {:id         => 1,
            :name       => 'Schroeder-Jerde',
            :created_at => '2012-03-27 14:53:59 UTC',
            :updated_at => '2012-03-27 14:53:59 UTC'
                                                    }
    merchant = Merchant.new(data)

    assert_equal 1, merchant.id
    assert_equal 'Schroeder-Jerde', merchant.name
    assert_equal '2012-03-27 14:53:59 UTC', merchant.created_at
    assert_equal '2012-03-27 14:53:59 UTC', merchant.updated_at
    # assert_instance_of Date, merchant.created_at
    # assert_instance_of Date, merchant.updated_at
  end
end
