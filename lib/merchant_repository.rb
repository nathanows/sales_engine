require_relative 'merchant'
require_relative 'repository'
require_relative 'finders/name_finder'

class MerchantRepository < Repository
  include NameFinder
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Merchant.new(entry) }
  end
end
