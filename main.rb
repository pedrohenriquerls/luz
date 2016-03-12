#!/usr/bin/env ruby

require 'csv'
require_relative 'model/product'
require_relative 'model/coupon'
require_relative 'model/order'

if ARGV.length != 5
  puts 'Wrong number of arguments'
else
  coupons_file = ARGV[0]
  products_file = ARGV[1]
  orders_file = ARGV[2]
  order_items_file = ARGV[3]

  CSV.foreach(coupons_file) do |row|
    Coupon.new(row[0], row[1], row[2], row[3], row[4]).save
  end

  CSV.foreach(products_file) do |row|
    Product.new(row[0], row[1]).save unless row[0].nil?
  end

  CSV.foreach(orders_file) do |row|
    Order.new(row[0], row[1]).save
  end

  CSV.foreach(order_items_file) do |row|
    order = Order.find(row[0])
    order.add_product(row[1])
    order.save
  end

  result_file = ARGV[4]

  CSV.open(result_file, 'wb') do |csv|
    Order.all.each_value do |order|
      csv << [order.id , order.value]
    end
  end

  puts 'Done! :)'
end