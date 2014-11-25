require_relative 'item'
require_relative 'repository'

class ItemRepository < Repository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Item.new(entry) }
  end

end
