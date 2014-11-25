require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def test_a_customer_has_attributes
    data = {:id         => 1,
            :first_name => 'Joey',
            :last_name  => 'Ondricka',
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    customer = Customer.new(data)

    assert_equal 1, customer.id
    assert_equal 'Joey', customer.first_name
    assert_equal 'Ondricka', customer.last_name
    assert_equal 'Joey Ondricka', customer.name
  end

  def test_that_it_parses_dates
    data = {:id         => 1,
            :first_name => 'Joey',
            :last_name  => 'Ondricka',
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    customer = Customer.new(data)

    assert_equal '2012-03-27', customer.created_at.to_s
    assert_equal '2012-03-27', customer.updated_at.to_s
    assert_instance_of Date, customer.created_at
    assert_instance_of Date, customer.updated_at
  end
end
