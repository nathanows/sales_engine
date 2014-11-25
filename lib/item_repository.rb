require_relative 'item'
require_relative 'repository'

class ItemRepository < Repository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Item.new(entry) }
  end

  def find_by_id(id)
    find_by :id, id
  end

  def find_by_name(name)
    find_by :name, name
  end

  def find_by_description(description)
    find_by :description, description
  end

  def find_by_unit_price(unit_price)
    find_by :unit_price, unit_price
  end

  def find_by_merchant_id(merchant_id)
    find_by :merchant_id, merchant_id
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

  def find_all_by_description(description)
    find_all_by :description, description
  end

  def find_all_by_unit_price(unit_price)
    find_all_by :unit_price, unit_price
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by :merchant_id, merchant_id
  end

  def find_all_by_created_at(created_at)
    find_all_by_date :created_at, created_at
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_date :updated_at, updated_at
  end
end
