require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def data1
   {:id         => 1,
    :name       => 'Schroeder-Jerde',
    :created_at => '2012-03-27 14:53:59 UTC',
    :updated_at => '2012-03-27 14:53:59 UTC'
                                            }
  end

  def data2
     {:id         => 2,
      :name       => 'Apple',
      :created_at => '2012-03-27 14:53:59 UTC',
      :updated_at => '2012-03-27 14:53:59 UTC'
                                              }
  end

  class InitializeMerchantTest < MerchantRepositoryTest
    def test_it_initializes_entries
      entries = [data1,data2]
      refute_empty entries
      merchant_repository = MerchantRepository.new(entries, nil)

      assert_equal 2, merchant_repository.data.length
      assert_equal 1, merchant_repository.data[0].id
      assert_equal 'Apple', merchant_repository.data[1].name
    end

    def test_that_it_creates_unique_objects
      entries = [data1,data2]
      refute_empty entries
      merchant_repository = MerchantRepository.new(entries, nil)

      refute merchant_repository.data[0].object_id == merchant_repository.data[1].object_id
    end
  end

  class FindMerchantTest < MerchantRepositoryTest
    attr_reader :new_obj
    def setup
      @new_obj = CSVParser.parse('merchants.csv', nil, CSVParser::TEST)
    end

    def test_it_creates_a_valid_object
      assert_instance_of MerchantRepository, new_obj
      assert_equal 100, new_obj.data.length
    end

    def test_it_can_return_first_instance_of_id
      find_results = new_obj.find_by_id(1)
      assert_instance_of Merchant, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_id
      find_results = new_obj.find_all_by_id(1)
      assert_equal 1, find_results.length
    end

    def test_it_can_return_first_instance_of_name
      find_results = new_obj.find_by_name("Williamson Group")
      assert_instance_of Merchant, find_results
      assert_equal 5, find_results.id
    end

    def test_it_can_return_all_instances_of_name
      find_results = new_obj.find_all_by_name("Williamson Group")
      assert_equal 2, find_results.length
    end

    def test_it_can_return_first_instance_of_created_at
      find_results = new_obj.find_by_created_at("2012-03-27")
      assert_instance_of Merchant, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_created_at
      find_results = new_obj.find_all_by_created_at("2012-03-27")
      assert_equal 100, find_results.length
    end

    def test_it_can_return_first_instance_of_updated_at
      find_results = new_obj.find_by_updated_at("2012-03-27")
      assert_instance_of Merchant, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_updated_at
      find_results = new_obj.find_all_by_updated_at("2012-03-27")
      assert_equal 100, find_results.length
    end
  end

  class MerchantDelegationTest < MerchantRepositoryTest
    attr_reader :merchant_repository, :sales_engine

    def setup
      entries = [data1,data2]
      @sales_engine = Minitest::Mock.new
      @merchant_repository = MerchantRepository.new(entries, @sales_engine)
    end

    def test_it_has_a_sales_engine
      assert merchant_repository.sales_engine
    end

    def test_it_delegates_items_to_sales_engine
      sales_engine.expect(:find_items_from_merchant, nil, [1])
      merchant_repository.find_items_from(1)
      sales_engine.verify
    end

    def test_it_delegates_invoices_to_sales_engine
      sales_engine.expect(:find_invoices_from_merchant, nil, [1])
      merchant_repository.find_invoices_from(1)
      sales_engine.verify
    end
  end
end
