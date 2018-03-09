require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(spaces)
    super(spaces)
    @type = 'Passenger'
  end

  def take_place
    @free_spaces -= 1 if @free_spaces >= 1
    @occupied_spaces = @spaces - @free_spaces
  end

end
