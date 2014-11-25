require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def test_it_initializes_entries
    data1 = {:id                 => 1,
            :invoice_id         => 1,
            :credit_card_number => 4654405418249632,
            :expiration_date    => '',
            :result             => 'success',
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    data2 = {:id                 => 2,
            :invoice_id         => 222,
            :credit_card_number => 4600005418249632,
            :expiration_date    => '',
            :result             => 'failed',
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    entries = [data1,data2]
    refute_empty entries
    transaction_repository = TransactionRepository.new(entries)

    assert_equal 2, transaction_repository.data.length
    assert_equal 'success', transaction_repository.data[0].result
    assert_equal 222, transaction_repository.data[1].invoice_id
  end

  def test_that_it_creates_unique_objects
    data1 = {:id                 => 1,
            :invoice_id         => 1,
            :credit_card_number => 4654405418249632,
            :expiration_date    => '',
            :result             => 'success',
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    data2 = {:id                 => 2,
            :invoice_id         => 222,
            :credit_card_number => 4600005418249632,
            :expiration_date    => '',
            :result             => 'failed',
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    entries = [data1,data2]
    refute_empty entries
    transaction_repository = TransactionRepository.new(entries)

    refute transaction_repository.data[0].object_id == transaction_repository.data[1].object_id
  end
end
