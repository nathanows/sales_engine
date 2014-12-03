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
      revenue = find_revenue_with_date(date)
      revenue/100 unless revenue.nil?
    else
      rev = find_revenue
      (rev / 100) unless rev.nil?
    end
  end

  def favorite_customer
    invoices_to_customers(successful_invoices).each_with_object(Hash.new(0)) do |customer, count|
      count[customer] += 1
    end.max_by { |key, value| value }.first
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
    invoices.select { |iv| iv.successful_transactions? }
  end

  def pending_invoices
    invoices.select { |iv| repository.pending_trans_from_invoice?(iv.id)}
  end

  def most_quantity
    repository.find_quantity_from(successful_invoices).reduce(:+)
  end
end
