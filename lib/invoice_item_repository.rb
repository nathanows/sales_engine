require_relative 'invoice_item'
require_relative 'repository'
require_relative 'finders/invoice_id_finder'
require_relative 'finders/unit_price_finder'

class InvoiceItemRepository < Repository
  include UnitPriceFinder
  include InvoiceIDFinder
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| InvoiceItem.new(entry) }
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
end
