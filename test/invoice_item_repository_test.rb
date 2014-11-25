require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_initializes_entries
    data1 = {:id         => 1,
             :item_id    => 539,
             :invoice_id => 1,
             :quantity   => 5,
             :unit_price => 13635,
             :created_at => '2012-03-27 14:54:09 UTC',
             :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    data2 = {:id         => 2,
             :item_id    => 402,
             :invoice_id => 2,
             :quantity   => 3,
             :unit_price => 17307,
             :created_at => '2012-03-27 14:54:09 UTC',
             :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }

    entries = [data1,data2]
    refute_empty entries
    invoice_item_repo = InvoiceItemRepository.new(entries)

    assert_equal 2, invoice_item_repo.data.length
    assert_equal 539, invoice_item_repo.data[0].item_id
    assert_equal 3, invoice_item_repo.data[1].quantity
  end

  def test_it_creates_unique_objects
    data1 = {:id         => 1,
             :item_id    => 539,
             :invoice_id => 1,
             :quantity   => 5,
             :unit_price => 13635,
             :created_at => '2012-03-27 14:54:09 UTC',
             :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    data2 = {:id         => 2,
             :item_id    => 402,
             :invoice_id => 2,
             :quantity   => 3,
             :unit_price => 17307,
             :created_at => '2012-03-27 14:54:09 UTC',
             :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }

    entries = [data1,data2]
    refute_empty entries
    invoice_item_repo = InvoiceItemRepository.new(entries)

    refute invoice_item_repo.data[0].object_id == invoice_item_repo.data[1].object_id
  end
end
