require_relative 'test_helper'
require_relative '../lib/repository'
require_relative '../lib/csv_parser'

class RepositoryTest < Minitest::Test
  def test_it_can_find_all_instances_of_criteria
    new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
    assert_instance_of CustomerRepository, new_obj
    assert_equal 51, new_obj.data.length

    assert_equal 2, new_obj.find_all_by(:first_name,'Charles').size
  end

  def test_it_can_find_first_instances_of_criteria
    new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
    assert_instance_of CustomerRepository, new_obj
    assert_equal 51, new_obj.data.length

    find_results = new_obj.find_by(:first_name,'Charles')
    assert_instance_of Customer, find_results
    assert_equal 'Jewess', find_results.last_name
  end

  def test_it_can_return_all
    new_obj = CSVParser.parse('customers.csv', nil, CSVParser::TEST)
    assert_instance_of CustomerRepository, new_obj
    assert_equal 51, new_obj.data.length

    assert_equal 51, new_obj.all.length
  end

  def test_it_can_return_random
    new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
    assert_instance_of InvoiceItemRepository, new_obj
    assert_equal 500, new_obj.data.length

    invoice_item1 = new_obj.random
    invoice_item2 = new_obj.random
    invoice_item3 = new_obj.random

    refute invoice_item1 == invoice_item2
    refute invoice_item2 == invoice_item3
    refute invoice_item1 == invoice_item3
  end
end
