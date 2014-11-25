require_relative 'customer'
require_relative 'repository'

class CustomerRepository < Repository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| Customer.new(entry) }
  end

  def find_by_id(id)                ; find_by id         end
  def find_by_first_name(first_name); find_by first_name end
  def find_by_last_name(last_name)  ; find_by last_name  end
  def find_by_created_at(created_at); find_by created_at end
  def find_by_updated_at(updated_at); find_by updated_at end

end
