require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_it_has_invoice_item_attributes
    data = {:id => 1,
            :item_id => 539,
            :invoice_id  => 1,
            :quantity => 5,
            :unit_price => 13635,
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC',
           }

    invoice_item = InvoiceItem.new(data)

    assert_equal 1, invoice_item.id
    assert_equal 539, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 5, invoice_item.quantity
    assert_equal 13635, invoice_item.unit_price
  end

  def test_that_it_parses_dates
    data = {:id => 1,
            :item_id => 539,
            :invoice_id  => 1,
            :quantity => 5,
            :unit_price => 13635,
            :created_at => '2012-03-27 14:54:09 UTC',
            :updated_at => '2012-03-27 14:54:09 UTC',
           }

    invoice_item = InvoiceItem.new(data)

    assert_equal '2012-03-27', invoice_item.created_at.to_s
    assert_equal '2012-03-27', invoice_item.updated_at.to_s
    assert_instance_of Date, invoice_item.created_at
    assert_instance_of Date, invoice_item.updated_at
  end
end
