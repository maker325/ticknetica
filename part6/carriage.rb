require_relative 'manufacturer'

class Carriage
  attr_reader :type
  include Manufacturer
end
