require 'rspec'
require_relative '../lib/model'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |c|
    #c.include RSpecMixin
    c.before(:all){ Model.clean_dataset }
end
