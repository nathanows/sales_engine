require_relative 'merchant'

class MerchantRepository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Merchant.new(entry) }
  end

end
