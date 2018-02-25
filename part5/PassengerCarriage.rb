require_relative 'Carriage'

class PassengerCarriage < Carriage
  attr_reader :type

  def initialize
    @type = 'Passenger'
  end
end
