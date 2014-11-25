class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(data)
    @id                  = data[:id]
    @invoice_id          = data[:invoice_id]
    @credit_card_number  = data[:credit_card_number]
    @expiration_date     = data[:expiration_date]
    @result              = data[:result]
    @created_at          = Date.parse(data[:created_at])
    @updated_at          = Date.parse(data[:updated_at])
  end

end
