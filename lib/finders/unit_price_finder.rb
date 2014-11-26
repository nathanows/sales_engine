module UnitPriceFinder
  def find_by_unit_price(unit_price)
    find_by :unit_price, unit_price
  end

  def find_all_by_unit_price(unit_price)
    find_all_by :unit_price, unit_price
  end
end
