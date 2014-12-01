require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def data1
     {:id                          => 1,
      :invoice_id                  => 1,
      :credit_card_number          => "4654405418249632",
      :credit_card_expiration_date => '',
      :result                      => 'success',
      :created_at                  => '2012-03-27 14:54:09 UTC',
      :updated_at                  => '2012-03-27 14:54:09 UTC'
                                                }
  end

  def data2
     {:id                          => 2,
      :invoice_id                  => 222,
      :credit_card_number          => "4600005418249632",
      :credit_card_expiration_date => '',
      :result                      => 'failed',
      :created_at                  => '2012-03-27 14:54:09 UTC',
      :updated_at                  => '2012-03-27 14:54:09 UTC'
                                                }
  end

  class InitializeTransactionTest < TransactionRepositoryTest
    def test_it_initializes_entries
      entries = [data1,data2]
      refute_empty entries
      transaction_repository = TransactionRepository.new(entries, nil)

      assert_equal 2, transaction_repository.data.length
      assert_equal 'success', transaction_repository.data[0].result
      assert_equal 222, transaction_repository.data[1].invoice_id
    end

    def test_that_it_creates_unique_objects
      entries = [data1,data2]
      refute_empty entries
      transaction_repository = TransactionRepository.new(entries, nil)

      refute transaction_repository.data[0].object_id == transaction_repository.data[1].object_id
    end
  end


  class FindTransactionTest < TransactionRepositoryTest
    attr_reader :new_obj

    def setup
      @new_obj = CSVParser.parse('transactions.csv', nil, CSVParser::TEST)
    end

    def test_it_creates_a_valid_object
      assert_instance_of TransactionRepository, new_obj
      assert_equal 250, new_obj.data.length
    end

    def test_it_can_return_first_instance_of_id
      find_results = new_obj.find_by_id(1)
      assert_instance_of Transaction, find_results
      assert_equal 1, find_results.invoice_id
    end

    def test_it_can_return_all_instances_of_id
      find_results = new_obj.find_all_by_id(1)
      assert_equal 1, find_results.length
    end

    def test_it_can_return_first_instance_of_invoice_id
      find_results = new_obj.find_by_invoice_id(4)
      assert_instance_of Transaction, find_results
      assert_equal 3, find_results.id
    end

    def test_it_can_return_all_instances_of_invoice_id
      find_results = new_obj.find_all_by_invoice_id(12)
      assert_equal 3, find_results.length
    end

    def test_it_can_return_first_instance_of_credit_card_number
      find_results = new_obj.find_by_credit_card_number("4763141973880496")
      assert_instance_of Transaction, find_results
      assert_equal 17, find_results.id
    end

    def test_it_can_return_all_instances_of_credit_card_number
      find_results = new_obj.find_all_by_credit_card_number("4763141973880496")
      assert_equal 1, find_results.length
    end

    def test_it_can_return_first_instance_of_credit_card_expiration_date
      find_results = new_obj.find_by_credit_card_expiration_date("10/14")
      assert_instance_of Transaction, find_results
      assert_equal 16, find_results.id
    end

    def test_it_can_return_all_instances_of_credit_card_expiration_date
      find_results = new_obj.find_all_by_credit_card_expiration_date("10/14")
      assert_equal 2, find_results.length
    end

    def test_it_can_return_first_instance_of_result
      find_results = new_obj.find_by_result("success")
      assert_instance_of Transaction, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_result
      find_results = new_obj.find_all_by_result("failed")
      assert_equal 39, find_results.length
    end

    def test_it_can_return_first_instance_of_created_at
      find_results = new_obj.find_by_created_at("2012-03-27")
      assert_instance_of Transaction, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_created_at
      find_results = new_obj.find_all_by_created_at("2012-03-27")
      assert_equal 250, find_results.length
    end

    def test_it_can_return_first_instance_of_updated_at
      find_results = new_obj.find_by_updated_at("2012-03-27")
      assert_instance_of Transaction, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_updated_at
      find_results = new_obj.find_all_by_updated_at("2012-03-27")
      assert_equal 250, find_results.length
    end
  end

  class TransactionDelegationTest < TransactionRepositoryTest
    attr_reader :sales_engine, :transaction_repository

    def setup
      entries = [data1, data2]
      @sales_engine = Minitest::Mock.new
      @transaction_repository = TransactionRepository.new(entries, @sales_engine)
    end

    def test_it_has_a_sales_engine
      assert transaction_repository.sales_engine
    end

    def test_it_delegates_invoice_to_sales_engine
      sales_engine.expect(:find_invoice_from_transaction, nil, [1])
      transaction_repository.find_invoice_from(1)
      sales_engine.verify
    end
  end
end
