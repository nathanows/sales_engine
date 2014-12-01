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
    @data.find do |date|
      date.send(attribute).to_date == Date.parse(criteria).to_date
    end
  end

  def find_all_by_date(attribute, criteria)
    @data.find_all do |date|
      date.send(attribute).to_date == Date.parse(criteria).to_date
    end
  end

  def find_by_id(id)
    find_by :id, id
  end

  def find_by_created_at(created_at)
    find_by_date :created_at, created_at
  end

  def find_by_updated_at(updated_at)
    find_by_date :updated_at, updated_at
  end

  def find_all_by_id(id)
    find_all_by :id, id
  end

  def find_all_by_created_at(created_at)
    find_all_by_date :created_at, created_at
  end

  def find_all_by_updated_at(updated_at)
    find_all_by_date :updated_at, updated_at
  end

  def inspect
    "#<#{self.class} #{@data.size} rows>"
  end

end
