require_relative 'item'

class ItemRepository
  attr_reader :data

  def initialize(entries)
    @data ||= entries.map { |entry| Item.new(entry) }
  end

end
