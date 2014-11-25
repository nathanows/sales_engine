require_relative 'customer'
require_relative 'repository'

class CustomerRepository < Repository
  attr_reader :data
  def initialize(entries)
    @data ||= entries.map { |entry| Customer.new(entry) }
  end

  def find_by_id(id)
    find_by :id, id
  end

  def find_by_first_name(first_name)
    find_by :first_name, first_name
  end

  def find_by_last_name(last_name)
    find_by :last_name, last_name
  end

  def find_by_created_at(created_at)
    find_by_date :created_at, created_at
  end

  def find_by_updated_at(updated_at)
    find_by_date :updated_at, updated_at
  end

  def find_all_by_id(id)
    find_all_by :id, id
  end

  def find_all_by_first_name(first_name)
    find_all_by :first_name, first_name
  end

  def find_all_by_last_name(last_name)
    find_all_by :last_name, last_name
  end

  def find_all_by_created_at(created_at)
    find_all_by_date :created_at, created_at
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_date :updated_at, updated_at
  end

end
