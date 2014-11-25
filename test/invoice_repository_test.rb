require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_initializes_with_attributes
    data1 = {:id          => 1,
             :customer_id => 1,
             :merchant_id => 26,
             :status      => 'shipped',
             :created_at  => '2012-03-25 09:54:09 UTC',
             :updated_at  => '2012-03-25 09:54:09 UTC',
                                                        }
    data2 = {:id          => 2,
             :customer_id => 2,
             :merchant_id => 69,
             :status      => 'shipped',
             :created_at  => '2012-03-25 09:54:09 UTC',
             :updated_at  => '2012-03-25 09:54:09 UTC',
                                                        }
    entries = [data1,data2]
    refute_empty entries
    invoice_repo = InvoiceRepository.new(entries)

    assert_equal 2, invoice_repo.data.length
    assert_equal 'shipped', invoice_repo.data[0].status
    assert_equal 69, invoice_repo.data[1].merchant_id
  end

  def test_it_creates_unique_objects
    data1 = {:id          => 1,
             :customer_id => 1,
             :merchant_id => 26,
             :status      => 'shipped',
             :created_at  => '2012-03-25 09:54:09 UTC',
             :updated_at  => '2012-03-25 09:54:09 UTC',
                                                        }
    data2 = {:id          => 2,
             :customer_id => 2,
             :merchant_id => 69,
             :status      => 'shipped',
             :created_at  => '2012-03-25 09:54:09 UTC',
             :updated_at  => '2012-03-25 09:54:09 UTC',
                                                        }
    entries = [data1,data2]
    refute_empty entries
    invoice_repo = InvoiceRepository.new(entries)

    refute invoice_repo.data[0].object_id == invoice_repo.data[1].object_id
  end
end
