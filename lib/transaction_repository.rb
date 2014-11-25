require_relative 'transaction'
require_relative 'repository'

class TransactionRepository < Repository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Transaction.new(entry) }
  end

end
