require_relative 'customer'
require_relative 'repository'

class CustomerRepository < Repository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| Customer.new(entry) }
  end

end
