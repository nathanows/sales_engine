class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @id          = data[:id]
    @item_id     = data[:item_id]
    @invoice_id  = data[:invoice_id]
    @quantity    = data[:quantity]
    @unit_price  = data[:unit_price]
    @created_at  = Date.parse(data[:created_at])
    @updated_at  = Date.parse(data[:updated_at])
  end
end
