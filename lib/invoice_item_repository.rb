require_relative 'invoice_item'
require_relative 'repository'

class InvoiceItemRepository < Repository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| InvoiceItem.new(entry) }
  end

  def find_by_id(id)
    find_by :id, id
  end

  def find_by_item_id(item_id)
    find_by :item_id, item_id
  end

  def find_by_invoice_id(invoice_id)
    find_by :invoice_id, invoice_id
  end

  def find_by_quantity(quantity)
    find_by :quantity, quantity
  end

  def find_by_unit_price(unit_price)
    find_by :unit_price, unit_price
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

  def find_all_by_item_id(item_id)
    find_all_by :item_id, item_id
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by :invoice_id, invoice_id
  end

  def find_all_by_quantity(quantity)
    find_all_by :quantity, quantity
  end

  def find_all_by_unit_price(unit_price)
    find_all_by :unit_price, unit_price
  end

  def find_all_by_created_at(created_at)
    find_all_by_date :created_at, created_at
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_date :updated_at, updated_at
  end
end
