require_relative '../lib/model'

class Product < Model
	attr_accessor :price

	def initialize(id, price)
		@id = id
		self.price = price.to_f
	end
end