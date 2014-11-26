module NameFinder
  def find_by_name(name)
    find_by :name, name
  end

  def find_all_by_name(name)
    find_all_by :name, name
  end
end
