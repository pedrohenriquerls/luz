#!/usr/bin/env ruby

require 'csv'
require_relative 'model/product'
require_relative 'model/coupon'
require_relative 'model/order'
require_relative 'lib/executer'

if ARGV.length != 5
  puts 'Wrong number of arguments'
else
  Executer.process(ARGV)
  puts 'Done! :)'
end