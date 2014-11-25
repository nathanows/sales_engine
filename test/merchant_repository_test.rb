require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_initializes_entries
    data1 = {:id         => 1,
            :name       => 'Schroeder-Jerde',
            :created_at => '2012-03-27 14:53:59 UTC',
            :updated_at => '2012-03-27 14:53:59 UTC'
                                                    }
    data2 = {:id         => 2,
            :name       => 'Apple',
            :created_at => '2012-03-27 14:53:59 UTC',
            :updated_at => '2012-03-27 14:53:59 UTC'
                                                    }
    entries = [data1,data2]
    refute_empty entries
    merchant_repository = MerchantRepository.new(entries)

    assert_equal 2, merchant_repository.data.length
    assert_equal 1, merchant_repository.data[0].id
    assert_equal 'Apple', merchant_repository.data[1].name
  end
end
