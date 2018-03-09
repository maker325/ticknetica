require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(spaces)
    super(spaces)
    @type = 'Cargo'
  end
end
