require_relative 'item'
require_relative 'repository'
require_relative 'finders/merchant_id_finder'
require_relative 'finders/name_finder'
require_relative 'finders/unit_price_finder'

class ItemRepository < Repository
  include MerchantIDFinder
  include NameFinder
  include UnitPriceFinder
  attr_reader :data,
              :sales_engine

  def initialize(entries, sales_engine)
    @sales_engine = sales_engine
    @data ||= entries.map { |entry| Item.new(entry, self) }
  end

  def find_by_description(description)
    find_by :description, description
  end

  def find_all_by_description(description)
    find_all_by :description, description
  end

  def find_invoice_items_from(id)
    sales_engine.find_invoice_items_from_item(id)
  end

  def find_merchant_from(id)
    sales_engine.find_merchant_from_item(id)
  end
end
