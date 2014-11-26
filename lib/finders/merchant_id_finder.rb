module MerchantIDFinder
  def find_by_merchant_id(merchant_id)
    find_by :merchant_id, merchant_id
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by :merchant_id, merchant_id
  end
end
