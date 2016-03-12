require 'byebug'

class Model
  @@data = {}
	attr_reader :id

	def self.find(id)
    @@data[self.name][id] rescue nil
	end

  def save
    data_set[id] = self
  end

  def self.clean_dataset
    @@data = {}
  end

  def self.all
    @@data[self.name]
  end

  protected
    def data_set
      data_set_name = self.class.name
      @@data[data_set_name] = {} if(@@data[data_set_name].nil?)
      @@data[data_set_name]
    end
end