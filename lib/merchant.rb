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
      find_revenue_with_date(date)
    else
      find_revenue
    end
  end

  def favorite_customer
    successful_customers.max_by { |customer| successful_customers.count(customer.name) }
  end

  def successful_customers
    repository.find_successful_customers(successful_invoices)
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
end
