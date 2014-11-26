module InvoiceIDFinder
  def find_by_invoice_id(invoice_id)
    find_by :invoice_id, invoice_id
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by :invoice_id, invoice_id
  end
end
