require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def test_it_initializes_entries
    data1 =  {:id        => 1,
             :first_name => 'Joey',
             :last_name  => 'Ondricka',
             :created_at => '2012-03-27 14:54:09 UTC',
             :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    data2 =  {:id        => 2,
             :first_name => 'Mary',
             :last_name  => 'Poppins',
             :created_at => '2012-03-27 14:54:09 UTC',
             :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    entries = [data1,data2]
    refute_empty entries
    customer_repo = CustomerRepository.new(entries)

    assert_equal 2, customer_repo.data.length
    assert_equal 'Joey', customer_repo.data[0].first_name
    assert_equal 'Mary Poppins', customer_repo.data[1].name
  end

  def test_that_it_creates_unique_objects
    data1 =  {:id         => 1,
              :first_name => 'Joey',
              :last_name  => 'Ondricka',
              :created_at => '2012-03-27 14:54:09 UTC',
              :updated_at => '2012-03-27 14:54:09 UTC'
                                                        }
    data2 =  {:id         => 2,
              :first_name => 'Mary',
              :last_name  => 'Poppins',
              :created_at => '2012-03-27 14:54:09 UTC',
              :updated_at => '2012-03-27 14:54:09 UTC'
                                                        }
    entries = [data1,data2]
    refute_empty entries
    customer_repo = CustomerRepository.new(entries)

    refute customer_repo.data[0].object_id == customer_repo.data[1].object_id
  end
end
