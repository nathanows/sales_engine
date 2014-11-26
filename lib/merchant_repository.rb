require_relative 'merchant'
require_relative 'repository'
require_relative 'finders/name_finder'

class MerchantRepository < Repository
  include NameFinder
  attr_reader :data,
              :sales_engine

  def initialize(entries, sales_engine)
    @sales_engine = sales_engine
    @data ||= entries.map { |entry| Merchant.new(entry, self) }
  end

  def find_items_from(id)
    sales_engine.find_items_from_merchant(id)
  end

  def find_invoices_from(id)
    sales_engine.find_invoices_from_merchant(id)
  end
end
