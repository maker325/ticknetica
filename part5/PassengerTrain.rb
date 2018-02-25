require_relative 'Train'

class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = 'Passenger'
  end

  def hook_carriage(carriage)
    super if carriage.class == PassengerCarriage
  end

  def unhook_carriage(carriage)
    super if carriage.class == PassengerCarriage
  end
end
