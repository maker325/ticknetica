require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    super(number, 'Cargo')
  end

  def hook_carriage(carriage)
    super if carriage.class == CargoCarriage
  end

  def unhook_carriage(carriage)
    super if carriage.class == CargoCarriage
  end
end
