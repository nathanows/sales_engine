require 'simplecov'
SimpleCov.start do
    add_filter "/test/"
end

require 'minitest/autorun'
require 'minitest/pride'
require 'date'
require_relative '../lib/csv_parser'
