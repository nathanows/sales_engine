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

  def find_all_by(attribute, criteria)
    @data.find_all { |record| record.send(attribute) == criteria }
  end

  def find_by_date(attribute, criteria)
    @data.find { |date| date.send(attribute).to_date == Date.parse(criteria).to_date }
  end

  def find_all_by_date(attribute, criteria)
    @data.find_all { |date| date.send(attribute).to_date == Date.parse(criteria).to_date }
  end
end
