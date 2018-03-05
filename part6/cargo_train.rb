require_relative 'train'

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = 'Cargo'
  end

  def hook_carriage(carriage)
    super if carriage.class == CargoCarriage
  end

  def unhook_carriage(carriage)
    super if carriage.class == CargoCarriage
  end
end
