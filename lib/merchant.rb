class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
    @repository = parent
  end

  def items
    repository.find_items_from(id)
  end

  def invoices
    repository.find_invoices_from(id)
  end

  def revenue
    repository.find_revenue_from(successful_invoices).reduce(:+)
  end

  def successful_invoices
    invoices.select { |iv| repository.successful_trans_from_invoice?(iv.id) }
  end
end
