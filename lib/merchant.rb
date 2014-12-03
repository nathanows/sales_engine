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
    rev = find_revenue(date)
    (rev / 100) unless rev.nil?
  end

  def favorite_customer
    invoices_to_customers(successful_invoices)
      .each_with_object(Hash.new(0)) { |customer, count|
        count[customer] += 1
      }.max_by { |key, value| value }.first
  end

  def customers_with_pending_invoices
    invoices_to_customers(pending_invoices)
  end

  def invoices_to_customers(invoices)
    repository.find_invoice_customers(invoices)
  end

  def find_revenue(date)
    repository.find_revenue_from(successful_invoices(date)).reduce(:+)
  end

  def successful_invoices(date = nil)
    succ_invoices = invoices.select { |iv| iv.successful_transactions? }
    if date.is_a? Range
       succ_invoices.select { |iv| date.include?(iv.created_at)}
    elsif date
       succ_invoices.select { |iv| iv.created_at == date }
    else
      succ_invoices
    end
  end

  def pending_invoices
    invoices.select { |iv| repository.pending_trans_from_invoice?(iv.id)}
  end

  def most_quantity
    repository.find_quantity_from(successful_invoices).reduce(:+)
  end
end
