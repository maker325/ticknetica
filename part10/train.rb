require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acсessors'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  include Aсcessors

  NUMBER_FORMAT = /^[a-zA-Zа-яА-Я0-9]{3}-?[a-zA-Zа-яА-Я0-9]{2}$/

  attr_reader :stations, :carriages, :number, :route, :type
  strong_attr_accessor :speed, Integer
  attr_accessor_with_history :color

  @@trains = {}

  def initialize(*args)
    @number = args[0]
    validate!
    @speed = 0
    @type = args[1]
    @carriages = []
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value if value < @speed
  end

  def hook_carriage(carriage)
    @carriages << carriage
  end

  def unhook_carriage(carriage)
    @carriages.delete(carriage)
  end

  def paste_route(route)
    @route = route
    @station_index = 0
    current_station.accept_train(self)
  end

  def go_to_next_station
    go_to_station(@station_index + 1) unless current_station == @route.stations.last
  end

  def go_to_previous_station
    go_to_station(@station_index - 1) unless @route.nil? || @station_index.zero?
  end

  def current_station
    @route.stations[@station_index] unless @route.nil?
  end

  def previous_station
    @station_index.zero? ? current_station : @route.stations[@station_index - 1]
  end

  def next_station
    if current_station == @route.stations.last
      current_station
    else
      @route.stations[@station_index + 1]
    end
  end

  def each_train(block)
    @carriages.each { |carriage| block.call(carriage) }
  end

  def info
    "Номер поезда #{number}. Тип: #{type}. Всего вагонов: #{carriages.count}"
  end

  protected

  # Its not safe to give this method from instance
  def go_to_station(index = 0)
    current_station.send_train(self)
    @route.stations[index].accept_train(self)
    @station_index = index
  end
end
