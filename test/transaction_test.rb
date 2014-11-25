require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def test_transaction_has_it_attributes
    data = {:id                 => 1,
            :invoice_id         => 1,
            :credit_card_number => 4654405418249632,
            :expiration_date    => '',
            :result             => 'success',
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC'
                                                      }
    transaction = Transaction.new(data)

    assert_equal 1, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 4654405418249632, transaction.credit_card_number
    assert_equal '', transaction.expiration_date
    assert_equal 'success', transaction.result
    assert_equal '2012-03-27 14:54:09 UTC', transaction.created_at
    assert_equal '2012-03-27 14:54:09 UTC', transaction.updated_at
  end
end
