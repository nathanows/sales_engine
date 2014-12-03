require 'csv'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'

class CSVParser
  PROD = './data/'
  TEST = './fixtures/'
  FILE_REPO_MAP  = {
                     'customers.csv'     => CustomerRepository,
                     'invoice_items.csv' => InvoiceItemRepository,
                     'invoices.csv'      => InvoiceRepository,
                     'items.csv'         => ItemRepository,
                     'merchants.csv'     => MerchantRepository,
                     'transactions.csv'  => TransactionRepository
                   }

  def self.parse(filename, sales_engine, filepath)
    FILE_REPO_MAP[filename].new(csv_rows(filename,filepath), sales_engine)
  end

  def self.csv_rows(filename, filepath)
    csv_to_hash(contents(filename, filepath))
  end

  def self.csv_to_hash(csv_rows)
    csv_rows.map(&:to_hash)
  end

  def self.contents(filename, filepath)
    read_in_csv(get_filepath(filename, filepath))
  end

  def self.read_in_csv(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

  def self.get_filepath(filename, filepath)
    File.join(filepath, filename)
  end
end
