class Repository
  def all
    @data
  end

  def random
    @data.sample
  end

  def find_by(criteria)
    attribute, search_criteria = criteria.first
    @data.find { |record| record.send(attribute) == search_criteria }
  end

  def find_by_all
    attribute, search_criteria = criteria.first
    @data.find_all { |record| record.send(attribute) == search_criteria }
  end
end
