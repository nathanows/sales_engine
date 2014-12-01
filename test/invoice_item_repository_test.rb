require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def data1
    { :id         => 1,
      :item_id    => 539,
      :invoice_id => 1,
      :quantity   => 5,
      :unit_price => 13635,
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
                                                }
  end

  def data2
    { :id         => 2,
      :item_id    => 402,
      :invoice_id => 2,
      :quantity   => 3,
      :unit_price => 17307,
      :created_at => '2012-03-27 14:54:09 UTC',
      :updated_at => '2012-03-27 14:54:09 UTC'
                                                }
  end

  class InitializeInvoiceItemTest < InvoiceItemRepositoryTest

    def test_it_initializes_entries
      entries = [data1,data2]
      refute_empty entries
      invoice_item_repo = InvoiceItemRepository.new(entries, nil)

      assert_equal 2, invoice_item_repo.data.length
      assert_equal 539, invoice_item_repo.data[0].item_id
      assert_equal 3, invoice_item_repo.data[1].quantity
    end

    def test_it_creates_unique_objects
      entries = [data1,data2]
      refute_empty entries
      invoice_item_repo = InvoiceItemRepository.new(entries, nil)

      refute invoice_item_repo.data[0].object_id == invoice_item_repo.data[1].object_id
    end
  end

  class FindInvoiceItemsTest < InvoiceItemRepositoryTest
    def test_it_can_return_all
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      assert_equal 500, new_obj.all.length
    end

    def test_it_can_return_first_instance_of_id
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_by_id(1)
      assert_instance_of InvoiceItem, find_results
      assert_equal 5, find_results.quantity
    end

    def test_it_can_return_all_instances_of_id
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      assert_equal 1, new_obj.find_all_by_id(5).size
    end

    def test_it_can_return_all_instances_of_invoice_id
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      assert_equal 8, new_obj.find_all_by_invoice_id(1).size
    end

    def test_it_can_return_first_instance_of_invoice_id
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_by_invoice_id(2)
      assert_instance_of InvoiceItem, find_results
      assert_equal 1832, find_results.item_id
    end


    def test_it_can_return_first_instance_of_item_id
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_by_item_id(1830)
      assert_instance_of InvoiceItem, find_results
      assert_equal 10, find_results.id
    end

    def test_it_can_return_all_instances_of_item_id
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      assert_equal 3, new_obj.find_all_by_item_id(1918).size
    end

    def test_it_can_return_first_instance_of_quantity
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_by_quantity(9)
      assert_instance_of InvoiceItem, find_results
      assert_equal 528, find_results.item_id
    end

    def test_it_can_return_all_instances_of_quantity
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      assert_equal 64, new_obj.find_all_by_quantity(5).size
    end

    def test_it_can_return_first_instance_of_unit_price
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_by_unit_price(521.00)
      assert_instance_of InvoiceItem, find_results
      assert_equal 5, find_results.quantity
    end

    def test_it_can_return_all_instances_of_unit_price
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      assert_equal 4, new_obj.find_all_by_unit_price(707.83).size
    end


    def test_it_can_return_first_instance_of_created_at
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_by_created_at('2012-03-27')
      assert_instance_of InvoiceItem, find_results
      assert_equal 13635, find_results.unit_price
    end

    def test_it_can_return_all_instances_of_created_at
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_all_by_created_at('2012-03-27')
      assert_equal 500, find_results.length
    end

    def test_it_can_return_first_instance_of_updated_at
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_by_updated_at('2012-03-27')
      assert_instance_of InvoiceItem, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_updated_at
      new_obj = CSVParser.parse('invoice_items.csv', nil, CSVParser::TEST)
      assert_instance_of InvoiceItemRepository, new_obj
      assert_equal 500, new_obj.data.length

      find_results = new_obj.find_all_by_updated_at('2012-03-27')
      assert_equal 500, find_results.length
    end
  end

  class InvoiceItemDelegationTest < InvoiceItemRepositoryTest
    attr_reader :invoice_item_repository, :sales_engine

    def setup
      entries = [data1,data2]
      @sales_engine = Minitest::Mock.new
      @invoice_item_repository = InvoiceItemRepository.new(entries, @sales_engine)
    end

    def test_it_has_a_sales_engine
      assert invoice_item_repository.sales_engine
    end

    def test_it_delegates_invoices_to_sales_engine
      sales_engine.expect(:find_invoice_from_invoice_item, nil, [1])
      invoice_item_repository.find_invoice_from(1)
      sales_engine.verify
    end

    def test_it_delegates_items_to_sales_engine
      sales_engine.expect(:find_item_from_invoice_item, nil, [539])
      invoice_item_repository.find_item_from(539)
      sales_engine.verify
    end
  end
end
