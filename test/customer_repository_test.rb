require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def data1
   {:id         => 1,
    :first_name => 'Joey',
    :last_name  => 'Ondricka',
    :created_at => '2012-03-27 14:54:09 UTC',
    :updated_at => '2012-03-27 14:54:09 UTC'
                                              }
  end

  def data2
   {:id         => 2,
    :first_name => 'Mary',
    :last_name  => 'Poppins',
    :created_at => '2012-03-27 14:54:09 UTC',
    :updated_at => '2012-03-27 14:54:09 UTC'
                                              }
  end

  class InitializeTest < CustomerRepositoryTest
    def test_it_initializes_entries
      entries = [data1,data2]
      refute_empty entries
      customer_repo = CustomerRepository.new(entries, nil)

      assert_equal 2, customer_repo.data.length
      assert_equal 'Joey', customer_repo.data[0].first_name
      assert_equal 'Mary Poppins', customer_repo.data[1].name
    end

    def test_that_it_creates_unique_objects
      entries = [data1,data2]
      refute_empty entries
      customer_repo = CustomerRepository.new(entries, nil)

      refute customer_repo.data[0].object_id == customer_repo.data[1].object_id
    end
  end

  class FindMethodTest < CustomerRepositoryTest
    def test_it_can_return_all
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      assert_equal 51, new_obj.all.length
    end

    def test_it_can_return_all_instances_of_first_name
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      assert_equal 2, new_obj.find_all_by_first_name('Charles').size
    end

    def test_it_can_return_first_instance_of_first_name
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      find_results = new_obj.find_by_first_name('Charles')
      assert_instance_of Customer, find_results
      assert_equal 'Jewess', find_results.last_name
    end


    def test_it_can_return_first_instance_of_last_name
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      find_results = new_obj.find_by_last_name('Jewess')
      assert_instance_of Customer, find_results
      assert_equal 'Charles', find_results.first_name
    end

    def test_it_can_return_all_instances_of_last_name
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      assert_equal 2, new_obj.find_all_by_last_name('macgyver').size
    end

    def test_it_can_return_first_instance_of_id
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      find_results = new_obj.find_by_id(1)
      assert_instance_of Customer, find_results
      assert_equal 'Joey', find_results.first_name
    end

    def test_it_can_return_all_instances_of_id
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      assert_equal 1, new_obj.find_all_by_id(5).size
    end

    def test_it_can_return_first_instance_of_created_at
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      find_results = new_obj.find_by_created_at('2012-03-27')
      assert_instance_of Customer, find_results
      assert_equal 'Joey', find_results.first_name
    end

    def test_it_can_return_all_instances_of_created_at
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      find_results = new_obj.find_all_by_created_at('2012-03-27')
      assert_equal 51, find_results.length
    end

    def test_it_can_return_first_instance_of_updated_at
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      find_results = new_obj.find_by_updated_at('2012-03-27')
      assert_instance_of Customer, find_results
      assert_equal 'Joey', find_results.first_name
    end

    def test_it_can_return_all_instances_of_updated_at
      new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
      assert_instance_of CustomerRepository, new_obj
      assert_equal 51, new_obj.data.length

      find_results = new_obj.find_all_by_updated_at('2012-03-27')
      assert_equal 51, find_results.length
    end
  end

  class CustomerDelegationTest < CustomerRepositoryTest
    attr_reader :sales_engine, :customer_repository

    def setup
      entries = [data1, data2]
      @sales_engine = Minitest::Mock.new
      @customer_repository = CustomerRepository.new(entries, @sales_engine)
    end

    def test_it_has_a_sales_engine
      assert customer_repository.sales_engine
    end

    def test_it_delegates_invoices_to_sales_engine
      sales_engine.expect(:find_invoices_from_customer, nil, [1])
      customer_repository.find_invoices_from(1)
      sales_engine.verify
    end
  end
end
