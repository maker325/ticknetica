require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize
    @type = 'Passenger'
  end
end
