require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Carriage
  include InstanceCounter
  include Manufacturer
  include Validation

  attr_reader :spaces, :free_spaces, :number, :type

  def initialize(*args)
    @spaces = args[0]
    validate!
    @free_spaces = @spaces
    register_instance
    @number = self.class.instances
    @type = args[1]
  end

  def take_place(space)
    @free_spaces -= space if @free_spaces >= space
  end

  def occupied_spaces
    @spaces - @free_spaces
  end

  def info
    "Номер вагона: #{number}. Тип #{type}."
  end

  protected

  def validate!
    raise 'Введите объём или количество мест!' if @spaces.nil? || @spaces =~ /\s/
    true
  end
end
