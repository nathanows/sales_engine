require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def data1
     {:id          => 1,
      :name        => 'Item Qui Esse',
      :description => 'Description here',
      :unit_price  => 75107,
      :merchant_id => 1,
      :created_at  => '2012-03-27 14:53:59 UTC',
      :updated_at  => '2012-03-27 14:53:59 UTC',
     }
  end

  def data2
     {:id          => 2,
      :name        => 'Item',
      :description => 'Another one here',
      :unit_price  => 7485,
      :merchant_id => 2,
      :created_at  => '2012-03-27 14:53:59 UTC',
      :updated_at  => '2012-03-27 14:53:59 UTC',
     }
  end

  class InitializeItemTest < ItemRepositoryTest
    def test_it_initializes_entries
      entries = [data1,data2]
      refute_empty entries
      item_repository = ItemRepository.new(entries, nil)

      assert_equal 2, item_repository.data.length
      assert_equal 'Item Qui Esse', item_repository.data[0].name
      assert_equal 2, item_repository.data[1].merchant_id
    end

    def test_that_it_creates_unique_objects
      entries = [data1,data2]
      refute_empty entries
      item_repository = ItemRepository.new(entries, nil)

      refute item_repository.data[0].object_id == item_repository.data[1].object_id
    end
  end


  class FindItemTest < ItemRepositoryTest
    attr_reader :new_obj
    def setup
      @new_obj = CSVParser.parse('items.csv', nil, CSVParser::TEST)
    end

    def test_it_creates_a_valid_object
      assert_instance_of ItemRepository, new_obj
      assert_equal 103, new_obj.data.length
    end

    def test_it_can_return_first_instance_of_id
      find_results = new_obj.find_by_id(1)
      assert_instance_of Item, find_results
      assert_equal "Item Qui Esse", find_results.name
    end

    def test_it_can_return_all_instances_of_id
      find_results = new_obj.find_all_by_id(1)
      assert_equal 1, find_results.length
    end

    def test_it_can_return_first_instance_of_name
      find_results = new_obj.find_by_name("Item Rerum Est")
      assert_instance_of Item, find_results
      assert_equal 15, find_results.id
    end

    def test_it_can_return_all_instances_of_name
      find_results = new_obj.find_all_by_name("Item Soluta Libero")
      assert_equal 4, find_results.length
    end

    def test_it_can_return_first_instance_of_description
      find_results = new_obj.find_by_description("Description")
      assert_instance_of Item, find_results
      assert_equal 102, find_results.id
    end

    def test_it_can_return_all_instances_of_description
      find_results = new_obj.find_all_by_description("Description")
      assert_equal 2, find_results.length
    end

    def test_it_can_return_first_instance_of_unit_price
      find_results = new_obj.find_by_unit_price(75107)
      assert_instance_of Item, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_unit_price
      find_results = new_obj.find_all_by_unit_price(75107)
      assert_equal 1, find_results.length
    end

    def test_it_can_return_first_instance_of_merchant_id
      find_results = new_obj.find_by_merchant_id(1)
      assert_instance_of Item, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_merchant_id
      find_results = new_obj.find_all_by_merchant_id(1)
      assert_equal 15, find_results.length
    end

    def test_it_can_return_first_instance_of_created_at
      find_results = new_obj.find_by_created_at("2012-03-27")
      assert_instance_of Item, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_created_at
      find_results = new_obj.find_all_by_created_at("2012-03-27")
      assert_equal 103, find_results.length
    end

    def test_it_can_return_first_instance_of_updated_at
      find_results = new_obj.find_by_updated_at("2012-03-27")
      assert_instance_of Item, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_updated_at
      find_results = new_obj.find_all_by_updated_at("2012-03-27")
      assert_equal 103, find_results.length
    end
  end

  class ItemDelegationTest < ItemRepositoryTest
    attr_reader :item_repository, :sales_engine

    def setup
      entries          = [data1,data2]
      @sales_engine    = Minitest::Mock.new
      @item_repository = ItemRepository.new(entries, @sales_engine)
    end

    def test_it_has_a_sales_engine
      assert item_repository.sales_engine
    end

    def test_it_delegates_invoices_to_sales_engine
      sales_engine.expect(:find_invoice_items_from_item, nil, [1])
      item_repository.find_invoice_items_from(1)
      sales_engine.verify
    end

    def test_it_delegates_items_to_sales_engine
      sales_engine.expect(:find_merchant_from_item, nil, [1])
      item_repository.find_merchant_from(1)
      sales_engine.verify
    end
  end
end
