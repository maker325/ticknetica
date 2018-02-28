require_relative 'Carriage'

class PassengerCarriage < Carriage
  def initialize
    @type = 'Passenger'
  end
end
