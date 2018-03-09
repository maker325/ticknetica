require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Carriage
  include InstanceCounter
  include Manufacturer
  include Validation
  
  attr_reader :spaces, :occupied_spaces, :free_spaces, :number, :type

  def initialize(spaces)
    @spaces = spaces
    validate!
    @free_spaces = @spaces
    @occupied_spaces = 0
    register_instance
    @number = self.class.instances
  end

  def take_place(space)
    @free_spaces -= space if @free_spaces >= space
    @occupied_spaces = @spaces - @free_spaces
  end

  protected

  def validate!
    raise 'Вагон не может быть без свободных мест или без свободного пространства' if spaces.nil? || spaces =~ /\s/

    true
  end

end
