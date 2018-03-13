require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super(number, 'Passenger')
  end

  def hook_carriage(carriage)
    super if carriage.class == PassengerCarriage
  end

  def unhook_carriage(carriage)
    super if carriage.class == PassengerCarriage
  end
end
