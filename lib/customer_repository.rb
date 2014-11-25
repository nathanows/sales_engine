require_relative 'customer'

class CustomerRepository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| Customer.new(entry) }
  end

end
