require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_reader :parent,
              :data,
              :item

  def setup
    @data   = {:id          => 1,
               :name        => 'Item Qui Esse',
               :description => 'Description here',
               :unit_price  => 75107,
               :merchant_id => 1,
               :created_at  => '2012-03-27 14:53:59 UTC',
               :updated_at  => '2012-03-27 14:53:59 UTC',
                                                          }
    @parent = Minitest::Mock.new
    @item   = Item.new(data, parent)
  end

  def test_it_has_item_attributes
    assert_equal 1, item.id
    assert_equal 'Item Qui Esse', item.name
    assert_equal 'Description here', item.description
    assert_equal 75107, item.unit_price
    assert_equal 1, item.merchant_id
  end

  def test_that_it_parses_dates
    assert_equal '2012-03-27', item.created_at.to_s
    assert_equal '2012-03-27', item.updated_at.to_s
    assert_instance_of Date, item.created_at
    assert_instance_of Date, item.updated_at
  end

  def test_it_delegates_find_invoice_items_to_item_repo
    parent.expect(:find_invoice_items_from, nil,[1] )
    item.invoice_items
    parent.verify
  end

  def test_it_delegates_find_merchant_to_item_repo
    parent.expect(:find_merchant_from, nil,[1] )
    item.merchant
    parent.verify
  end
end
