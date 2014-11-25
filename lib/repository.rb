class Repository
  def all
    @data
  end

  def random
    @data.sample
  end

  def find_by(attribute, criteria)
    @data.find { |record| record.send(attribute) == criteria }
  end

  def find_by_all(attribute, criteria)
    @data.find_all { |record| record.send(attribute) == criteria }
  end
end
