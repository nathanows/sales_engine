require_relative 'invoice'

class InvoiceRepository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| Invoice.new(entry) }
  end
end
