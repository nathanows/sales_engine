require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_initializes_entries
    data1 = {:id          => 1,
            :name        => 'Item Qui Esse',
            :description => 'Description here',
            :unit_price  => 75107,
            :merchant_id => 1,
            :created_at  => '2012-03-27 14:53:59 UTC',
            :updated_at  => '2012-03-27 14:53:59 UTC',
           }
    data2 = {:id          => 2,
            :name        => 'Item',
            :description => 'Another one here',
            :unit_price  => 7485,
            :merchant_id => 2,
            :created_at  => '2012-03-27 14:53:59 UTC',
            :updated_at  => '2012-03-27 14:53:59 UTC',
           }
    entries = [data1,data2]
    refute_empty entries
    item_repository = ItemRepository.new(entries)

    assert_equal 2, item_repository.data.length
    assert_equal 'Item Qui Esse', item_repository.data[0].name
    assert_equal 2, item_repository.data[1].merchant_id
  end

  def test_that_it_creates_unique_objects
    data1 = {:id          => 1,
            :name        => 'Item Qui Esse',
            :description => 'Description here',
            :unit_price  => 75107,
            :merchant_id => 1,
            :created_at  => '2012-03-27 14:53:59 UTC',
            :updated_at  => '2012-03-27 14:53:59 UTC',
           }
    data2 = {:id          => 2,
            :name        => 'Item',
            :description => 'Another one here',
            :unit_price  => 7485,
            :merchant_id => 2,
            :created_at  => '2012-03-27 14:53:59 UTC',
            :updated_at  => '2012-03-27 14:53:59 UTC',
           }
    entries = [data1,data2]
    refute_empty entries
    item_repository = ItemRepository.new(entries)

    refute item_repository.data[0].object_id == item_repository.data[1].object_id
  end
end
