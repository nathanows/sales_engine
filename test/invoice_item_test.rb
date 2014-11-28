require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :parent,
              :data,
              :invoice_item

  def setup
    @data = {:id => 1,
             :item_id => 539,
             :invoice_id  => 1,
             :quantity => 5,
             :unit_price => 13635,
             :created_at => '2012-03-27 14:54:09 UTC',
             :updated_at => '2012-03-27 14:54:09 UTC',
                                                      }
    @parent       = Minitest::Mock.new
    @invoice_item = InvoiceItem.new(data, parent)


  end
  def test_it_has_invoice_item_attributes
    assert_equal 1, invoice_item.id
    assert_equal 539, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 5, invoice_item.quantity
    assert_equal 13635, invoice_item.unit_price
  end

  def test_that_it_parses_dates
    assert_equal '2012-03-27', invoice_item.created_at.to_s
    assert_equal '2012-03-27', invoice_item.updated_at.to_s
    assert_instance_of Date, invoice_item.created_at
    assert_instance_of Date, invoice_item.updated_at
  end

  def test_it_delegates_find_invoice_to_invoice_item_repo
    parent.expect(:find_invoice_from, nil,[1] )
    invoice_item.invoice
    parent.verify
  end

  def test_it_delegates_find_items_to_invoice_item_repo
    parent.expect(:find_item_from, nil,[539] )
    invoice_item.item
    parent.verify
  end
end
