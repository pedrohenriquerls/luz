require 'spec_helper'
require_relative '../../lib/executer'

describe Executer do
  it 'should do something' do
    args = %w(spec/fixtures/coupons.csv spec/fixtures/products.csv spec/fixtures/orders.csv spec/fixtures/order_items.csv spec/fixtures/output.csv)
    Executer.process(args)

    result = CSV.read('spec/fixtures/output.csv')
    expect(result[0]).to match(%w(123 2250.0))
    expect(result[1]).to match(%w(234 216.75))
    expect(result[2]).to match(%w(345 314.5))
    expect(result[3]).to match(%w(456 427.5))
    expect(result[4]).to match(%w(567 525.0))
    expect(result[5]).to match(%w(678 2227.5))
  end
end