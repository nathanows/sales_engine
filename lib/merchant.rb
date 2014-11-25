class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
  end
end
