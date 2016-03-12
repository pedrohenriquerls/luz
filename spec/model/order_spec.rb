require_relative '../../model/order'
require_relative '../../model/product'
require 'spec_helper'

describe Order do
  describe '.save' do
    it 'should return nil' do
      expect(Order.find(0)).to be nil
    end

    it 'should return id 0' do
      Order.new(0, 1).save
      Order.new(1, 2).save

      order = Order.find(0)
      expect(order.id).to eq 0
    end
  end

  let(:order){Order.find(0)}

  describe '.total' do
    before(:all) do
      build_order
    end

    it 'sum all prices' do
      expect(order.total).to eq(7)
    end
  end

  describe '.value' do
    it 'value with absolute discount' do
      build_order(Coupon::ABSOLUTE)
      expect(order.value).to eq(5)
    end

    it 'value with progressive discount' do
      build_order(Coupon::PERCENT)
      expect(order.value).to eq(5.95)
    end
  end

  private
    def build_order(coupon_type = nil)
      Coupon.new(0, '2', coupon_type, '2016/07/01', 1).save

      o = Order.new(0, 0)
      p = Product.new(0, 2.5)
      p.save
      o.add_product(p.id)
      p = Product.new(1, 1)
      p.save
      o.add_product(p.id)
      p = Product.new(2, 3.5)
      p.save
      o.add_product(p.id)

      o.save
    end
end