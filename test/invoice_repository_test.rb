require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def data1
    { :id          => 1,
      :customer_id => 1,
      :merchant_id => 26,
      :status      => 'shipped',
      :created_at  => '2012-03-25 09:54:09 UTC',
      :updated_at  => '2012-03-25 09:54:09 UTC',
                                                }
  end

  def data2
    { :id          => 2,
      :customer_id => 2,
      :merchant_id => 69,
      :status      => 'shipped',
      :created_at  => '2012-03-25 09:54:09 UTC',
      :updated_at  => '2012-03-25 09:54:09 UTC',
                                                }
  end

  class InitializeInvoiceTest < InvoiceRepositoryTest
    def test_it_initializes_with_attributes
      entries = [data1,data2]
      refute_empty entries
      invoice_repo = InvoiceRepository.new(entries)

      assert_equal 2, invoice_repo.data.length
      assert_equal 'shipped', invoice_repo.data[0].status
      assert_equal 69, invoice_repo.data[1].merchant_id
    end

    def test_it_creates_unique_objects
      entries = [data1,data2]
      refute_empty entries
      invoice_repo = InvoiceRepository.new(entries)

      refute invoice_repo.data[0].object_id == invoice_repo.data[1].object_id
    end
  end

  class FindInvoiceTest < InvoiceRepositoryTest
    def test_it_can_return_all
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      assert_equal 100, new_obj.all.length
    end

    def test_it_can_return_first_instance_of_id
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      find_results = new_obj.find_by_id(10)
      assert_instance_of Invoice, find_results
      assert_equal 3, find_results.customer_id
    end

    def test_it_can_return_all_instances_of_id
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      assert_equal 1, new_obj.find_all_by_id(45).size
    end

    def test_it_can_return_all_instances_of_customer_id
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      assert_equal 8, new_obj.find_all_by_customer_id(1).size
    end

    def test_it_can_return_first_instance_of_customer_id
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      find_results = new_obj.find_by_customer_id(2)
      assert_instance_of Invoice, find_results
      assert_equal 27, find_results.merchant_id
    end


    def test_it_can_return_first_instance_of_merchant_id
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      find_results = new_obj.find_by_merchant_id(90)
      assert_instance_of Invoice, find_results
      assert_equal 21, find_results.id
    end

    def test_it_can_return_all_instances_of_merchant_id
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      assert_equal 2, new_obj.find_all_by_merchant_id(52).size
    end

    def test_it_can_return_first_instance_of_status
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      find_results = new_obj.find_by_status('shipped')
      assert_instance_of Invoice, find_results
      assert_equal 1, find_results.id
    end

    def test_it_can_return_all_instances_of_status
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      assert_equal 100, new_obj.find_all_by_status('shipped').size
    end

    def test_it_can_return_first_instance_of_created_at
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      find_results = new_obj.find_by_created_at('2012-03-27')
      assert_instance_of Invoice, find_results
      assert_equal 25, find_results.id
    end

    def test_it_can_return_all_instances_of_created_at
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      find_results = new_obj.find_all_by_created_at('2012-03-16')
      assert_equal 5, find_results.length
    end

    def test_it_can_return_first_instance_of_updated_at
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      find_results = new_obj.find_by_updated_at('2012-03-27')
      assert_instance_of Invoice, find_results
      assert_equal 25, find_results.id
    end

    def test_it_can_return_all_instances_of_updated_at
      new_obj = CSVParser.parse('invoices.csv', CSVParser::TEST)
      assert_instance_of InvoiceRepository, new_obj
      assert_equal 100, new_obj.data.length

      find_results = new_obj.find_all_by_updated_at('2012-03-27')
      assert_equal 6, find_results.length
    end
  end
end
