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

  def revenue(date = nil)
    if date
      (find_revenue_with_date(date) / 100)
    else
      (find_revenue / 100)
    end
  end

  def favorite_customer
    invoices_to_customers(successful_invoices).max_by { |customer| invoices_to_customers(successful_invoices).count(customer.name) }
  end

  def customers_with_pending_invoices
    invoices_to_customers(pending_invoices)
  end

  def invoices_to_customers(invoices)
    repository.find_invoice_customers(invoices)
  end

  def find_revenue_with_date(date)
    repository.find_revenue_from(successful_invoices_dated(date)).reduce(:+)
  end

  def find_revenue
    repository.find_revenue_from(successful_invoices).reduce(:+)
  end

  def successful_invoices_dated(date)
    successful_invoices.select { |iv| iv.created_at == date}
  end

  def successful_invoices
    invoices.select { |iv| repository.successful_trans_from_invoice?(iv.id) }
  end

  def pending_invoices
    invoices.select { |iv| repository.pending_trans_from_invoice?(iv.id)}
  end
end
