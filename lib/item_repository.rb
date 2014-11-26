require_relative 'item'
require_relative 'repository'
require_relative 'finders/merchant_id_finder'
require_relative 'finders/name_finder'
require_relative 'finders/unit_price_finder'

class ItemRepository < Repository
  include MerchantIDFinder
  include NameFinder
  include UnitPriceFinder
  attr_reader :data

  def initialize(entries, sales_engine)
    @data ||= entries.map { |entry| Item.new(entry) }
  end

  def find_by_description(description)
    find_by :description, description
  end

  def find_all_by_description(description)
    find_all_by :description, description
  end
end
