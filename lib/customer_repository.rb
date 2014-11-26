require_relative 'customer'
require_relative 'repository'

class CustomerRepository < Repository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| Customer.new(entry) }
  end

  def find_by_first_name(first_name)
    find_by :first_name, first_name
  end

  def find_by_last_name(last_name)
    find_by :last_name, last_name
  end

  def find_all_by_first_name(first_name)
    find_all_by :first_name, first_name
  end

  def find_all_by_last_name(last_name)
    find_all_by :last_name, last_name
  end
end
