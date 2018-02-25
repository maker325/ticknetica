require_relative 'Carriage'

class CargoCarriage < Carriage
  attr_reader :type

  def initialize
    @type = 'Cargo'
  end
end
