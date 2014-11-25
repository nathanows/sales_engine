require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository < Repository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| Invoice.new(entry) }
  end
end
