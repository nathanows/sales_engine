require_relative 'merchant'
require_relative 'repository'

class MerchantRepository < Repository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Merchant.new(entry) }
  end

  def find_by_id(id)
    find_by :id, id
  end

  def find_by_name(name)
    find_by :name, name
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

  def find_all_by_name(name)
    find_all_by :name, name
  end

  def find_all_by_created_at(created_at)
    find_all_by_date :created_at, created_at
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_date :updated_at, updated_at
  end

end
