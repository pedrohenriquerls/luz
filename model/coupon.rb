require_relative '../lib/model'

class Coupon < Model
  PERCENT = 'percent'
  ABSOLUTE = 'absolute'
  TYPES = [PERCENT, ABSOLUTE]
  attr_accessor :value, :type, :expires, :points

  def initialize(id, value, type, expires, points)
    @id = id
    self.value = value.to_f
    self.type = type
    self.expires = Date.strptime(expires, '%Y/%m/%d')
    self.points = points.to_i
  end

  def discount(total = nil)
    if valid? && valid_to_discount?
      discount = 0

      if type == ABSOLUTE
        discount = value
      elsif type == PERCENT
        discount = value * total / 100
      end

      @points -= 1 if discount > 0
      save

      discount
    else
      0
    end
  end

  def valid_to_discount?
    points > 0 && expires >= Date.today
  end

  def valid?
    TYPES.include?(type) && value.is_a?(Float)
  end
end