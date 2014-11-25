class Repository
  def all
    @data
  end

  def random
    @data.sample
  end

  def find_by(criteria)
    @data.find { |record| record.send(criteria) == criteria }
  end

  def find_by_all(criteria)
    @data.find_all { |record| record.send(criteria) == criteria }
  end
end
