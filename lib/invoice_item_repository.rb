require_relative 'invoice_item'
require_relative 'repository'

class InvoiceItemRepository < Repository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| InvoiceItem.new(entry) }
  end
end
