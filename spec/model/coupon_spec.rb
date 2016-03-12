require_relative '../../model/coupon'
require 'spec_helper'

describe Coupon do
  describe '.save' do
    it 'should return nil' do
      expect(Coupon.find(0)).to be nil
    end

    it 'should return id 0' do
      coupon = Coupon.new(0, 2.5, 'test', '2016/07/01', 1)
      coupon.save

      coupon = Coupon.new(1, 3.5, 'test', '2016/07/01', 2)
      coupon.save

      coupon = Coupon.find(0)
      expect(coupon.id).to eq 0
    end
  end

  describe 'valid?' do
    it 'should be invalid' do
      coupon = Coupon.new(0, 2.5, 'test', '2016/07/01', 1)
      expect(coupon.valid?).to be false

      coupon.type = Coupon::ABSOLUTE
      coupon.value = 2.to_i
      expect(coupon.valid?).to be false
    end

    it 'should be valid' do
      result = Coupon.new(0, '2', Coupon::ABSOLUTE, '2016/07/01', 1).valid?
      expect(result).to be true
    end
  end

  describe '.discount' do
    it 'absolute' do
      coupon = Coupon.new(0, '2', Coupon::ABSOLUTE, '2016/07/01', 1)
      expect(coupon.discount).to eq(2.0)
      expect(Coupon.find(0).points).to eq(0)

      expect(coupon.discount).to eq(0)
    end

    it 'percent' do
      coupon = Coupon.new(0, '2', Coupon::PERCENT, '2016/07/01', 1)
      expect(coupon.discount(3)).to eq(0.06)
      expect(Coupon.find(0).points).to eq(0)

      expect(coupon.discount).to eq(0)
    end

    it 'no products with percent' do
      coupon = Coupon.new(1, '2', Coupon::PERCENT, '2016/07/01', 1)
      expect(coupon.discount(0)).to eq(0)
      expect(Coupon.find(1).points).to eq(1)
    end

    it 'price total equal 10' do
      coupon = Coupon.new(1, '2', Coupon::PERCENT, '2016/07/01', 1)
      expect(coupon.discount(10)).to eq(0.2)
      expect(Coupon.find(1).points).to eq(0)
    end
  end
end