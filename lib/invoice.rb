class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = Date.parse(data[:created_at])
    @updated_at  = Date.parse(data[:updated_at])
    @repository  = parent
  end

  def successful_transactions?
    @successful ||= transactions.any? { |trans| trans.result == "success" }
  end

  def transactions
    repository.find_transactions_from(id)
  end

  def invoice_items
    repository.find_invoice_items_from(id)
  end

  def customer
    repository.find_customer_from(customer_id)
  end

  def merchant
    repository.find_merchant_from(merchant_id)
  end

  def items
    repository.find_items_from(id)
  end

  def charge(options = {})
    cc_num  = options[:credit_card_number]
    cc_exp  = options[:credit_card_expiration]
    result  = options[:result]
    repository.charge_invoice(cc_num, cc_exp, result, self.id)
  end

end
