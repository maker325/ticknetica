require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Carriage
  include InstanceCounter
  include Manufacturer
  include Validation

  attr_reader :spaces, :free_spaces, :number, :type

  def initialize(spaces)
    @spaces = spaces.to_i
    validate!
    @free_spaces = @spaces
    register_instance
    @number = self.class.instances
    @type = 'Cargo' if self.class == CargoCarriage
    @type = 'Passenger' if self.class == PassengerCarriage
  end

  def take_place(space)
    @free_spaces -= space if @free_spaces >= space
  end

  protected

  def validate!
    raise 'Вагон не может быть без свободных мест или без свободного пространства' if spaces.nil? || spaces =~ /\s/

    true
  end

end
