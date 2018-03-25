require_relative 'carriage'

class CargoCarriage < Carriage
  validate :spaces, :presence

  def initialize(spaces)
    super(spaces, 'Cargo')
  end

  def info_space
    " Свободно пространства в вагоне: #{free_spaces}m3. Занято: #{occupied_spaces}m3."
  end
end
