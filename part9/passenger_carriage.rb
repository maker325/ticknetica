require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(spaces)
    super(spaces, 'Passenger')
  end

  def take_place
    super(1)
  end

  def info_space
    " Свободно мест в вагоне: #{free_spaces}. Занято: #{occupied_spaces}."
  end
end
