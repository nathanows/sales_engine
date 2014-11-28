require_relative 'invoice_item'
require_relative 'repository'
require_relative 'finders/invoice_id_finder'
require_relative 'finders/unit_price_finder'

class InvoiceItemRepository < Repository
  include UnitPriceFinder
  include InvoiceIDFinder
  attr_reader :data,
              :sales_engine

  def initialize(entries, sales_engine)
    @sales_engine = sales_engine
    @data ||= entries.map { |entry| InvoiceItem.new(entry, self) }
  end

  def find_by_item_id(item_id)
    find_by :item_id, item_id
  end

  def find_by_quantity(quantity)
    find_by :quantity, quantity
  end

  def find_all_by_item_id(item_id)
    find_all_by :item_id, item_id
  end

  def find_all_by_quantity(quantity)
    find_all_by :quantity, quantity
  end

  def find_invoice_from(invoice_id)
    sales_engine.find_invoice_from_invoice_item(invoice_id)
  end

  def find_item_from(item_id)
    sales_engine.find_item_from_invoice_item(item_id)
  end
end
