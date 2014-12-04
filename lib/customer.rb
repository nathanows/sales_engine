class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
    @repository = parent
  end

  def name
    "#{first_name} #{last_name}"
  end

  def invoices
    repository.find_invoices_from(id)
  end

  def transactions
    repository.find_transactions_from(id)
  end

  def favorite_merchant
    repository.find_favorite_merchant_from(id)
  end

  def successful_invoices(date = nil)
    succ_invoices = invoices.select { |inv| inv.successful_transactions? }
    date ? succ_invoices.select { |inv| inv.created_at == date} : succ_invoices
  end

  def most_quantity
    repository.find_quantity_from(successful_invoices).reduce(:+)
  end

  def most_revenue
    repository.find_revenue_from(successful_invoices).reduce(:+)
  end

  def pending_invoices
    invoices.select { |invoice| !invoice.successful_transactions? } || []
  end

  def days_since_activity
    (Date.today - transactions.max_by { |trans|
                  trans.updated_at}.updated_at).to_i
  end
end
