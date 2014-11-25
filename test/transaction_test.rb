require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def test_transaction_has_it_attributes
    data = {:id                          => 1,
            :invoice_id                  => 1,
            :credit_card_number          => 4654405418249632,
            :credit_card_expiration_date => '10/14',
            :result                      => 'success',
            :created_at                  => '2012-03-27 14:54:09 UTC',
            :updated_at                  => '2012-03-27 14:54:09 UTC'
                                                      }
    transaction = Transaction.new(data)

    assert_equal 1, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 4654405418249632, transaction.credit_card_number
    assert_equal '10/14', transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
  end

  def test_that_it_parses_dates
    data = {:id                          => 1,
            :invoice_id                  => 1,
            :credit_card_number          => 4654405418249632,
            :credit_card_expiration_date => '',
            :result                      => 'success',
            :created_at                  => '2012-03-27 14:54:09 UTC',
            :updated_at                  => '2012-03-27 14:54:09 UTC'
                                                      }
    transaction = Transaction.new(data)

    assert_equal '2012-03-27', transaction.created_at.to_s
    assert_equal '2012-03-27', transaction.updated_at.to_s
    assert_instance_of Date, transaction.created_at
    assert_instance_of Date, transaction.updated_at
  end
end
