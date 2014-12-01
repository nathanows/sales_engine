require_relative 'invoice_item'
require_relative 'repository'
require_relative 'finders/invoice_id_finder'
require_relative 'finders/unit_price_finder'

class InvoiceItemRepository < Repository
  include UnitPriceFinder
  include InvoiceIDFinder
  attr_reader :sales_engine
  attr_accessor :data

  def initialize(entries, sales_engine)
    @sales_engine = sales_engine
    @data ||= entries.map { |entry| InvoiceItem.new(entry, self) }
  end

  def find_by_item_id(item_id)
    find_by :item_id, item_id
  end

  def find_by_quantity(quantity)
    find_by :quantity, quantity
  end

  def find_all_by_item_id(item_id)
    find_all_by :item_id, item_id
  end

  def find_all_by_quantity(quantity)
    find_all_by :quantity, quantity
  end

  def find_invoice_from(invoice_id)
    sales_engine.find_invoice_from_invoice_item(invoice_id)
  end

  def find_item_from(item_id)
    sales_engine.find_item_from_invoice_item(item_id)
  end

  def add(invoice_id, items)
    item_groups(items).each do |item, count|
      new_invoice_item(invoice_id, item, count)
    end
  end

  def item_groups(items)
    items.each_with_object(Hash.new(0)) { |item, count| count[item] += 1 }
  end

  def new_invoice_item(invoice, item, quantity)
    invoice_item = {
      :id         => next_id,
      :item_id    => item.id,
      :invoice_id => invoice.id,
      :quantity   => quantity,
      :unit_price => item.unit_price,
      :created_at => Date.today.to_s,
      :updated_at => Date.today.to_s
    }
    self.data << InvoiceItem.new(invoice_item, self)
  end

  def next_id
    data.max_by { |invoice_item| invoice_item.id }.id + 1
  end
end
