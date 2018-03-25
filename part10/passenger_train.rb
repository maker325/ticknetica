require_relative 'train'

class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

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
