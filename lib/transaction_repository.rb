require_relative 'transaction'

class TransactionRepository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Transaction.new(entry) }
  end

end
