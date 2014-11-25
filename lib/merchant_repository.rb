require_relative 'merchant'
require_relative 'repository'

class MerchantRepository < Repository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Merchant.new(entry) }
  end

end
