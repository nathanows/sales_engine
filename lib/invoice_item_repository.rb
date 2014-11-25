require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| InvoiceItem.new(entry) }
  end
end
