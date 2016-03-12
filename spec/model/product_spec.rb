require_relative '../../model/product'
require 'spec_helper'

describe Product do
  describe '.save' do
    it 'should return nil' do
      expect(Product.find(0)).to be nil
    end

    it 'should return id 0' do
      Product.new(0, 1).save
      Product.new(1, 2).save

      product = Product.find(0)
      expect(product.id).to eq 0
    end
  end
end