require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(spaces)
    super(spaces)
  end

  def take_place
    super(1)
  end

end
