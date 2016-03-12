class Order < Model
  attr_reader :coupon

  def initialize(id, cupom_id)
    @products = []
    @id = id
    @coupon = Coupon.find(cupom_id)
  end

  def total
    @products.collect(&:price).inject(:+)
  end

  def value
    product_sum = total
    discount = @coupon.discount(product_sum) rescue 0
    total - [discount, progressive_discount(product_sum)].max
  end

  def add_product(id)
    @products << Product.find(id)
  end

  def progressive_discount(total)
    products_amount = @products.length
    if products_amount >= 2
      products_amount = 8 if products_amount > 8
      total * products_amount.to_f*5/100
    else
      0
    end
  end
end