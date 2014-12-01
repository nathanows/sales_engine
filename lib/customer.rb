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
end
