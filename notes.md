class GenericRepository
  def all
    @entries.all
  end

  def random
    @entries.sample
  end
end

class MerchantRepository < GenericRepository
  j
end

class InvoiceRepositroy < GenericRepository

class SalesEngine
  def initialize
    @merhant_repo
    @invoice_repo
  end

  def startup
    @merhant_repo = CSVParser.parse(filename)
    @invoice_repo = CSVParser.parse(invoice.csv)
    @
  end
end

class CSVParser
  REPO_MAP = {'invoice.csv' => InvoiceRepository}

  def self.parse(filename)
    REPO_MAP[filename] = repo
    open_file
    convert to hashes
    repo.new(data_as_hashes)
  end

  def open_file()
  end

  def to_hash
  end
end
