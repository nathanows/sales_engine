require 'simplecov'
SimpleCov.start do
    add_filter "/test/"
end

require 'minitest/autorun'
require 'minitest/pride'
require 'date'
require 'bigdecimal'
require_relative '../lib/csv_parser'
