require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  attr_reader :stations, :speed, :carriages, :number, :route
  include Manufacturer
  include InstanceCounter
  @@trains = {}

  def initialize(number)
    @number = number
    @speed = 0
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

  def set_route(route)
    @route = route
    @station_index = 0
    current_station.accept_train(self)
  end

  def go_to_next_station
    if current_station != @route.stations.last
      go_to_station(@station_index + 1)
      puts 'Перемещение вперед прошло успешно'
    else
      puts 'Поезд не переместился, так как он на конечной станции'
    end
  end

  def go_to_previous_station
    if @route.nil? || @station_index == 0
      puts 'Поезд не переместился, так как он на начальной станции'
    else
      go_to_station(@station_index - 1)
      puts 'Перемещение назад прошло успешно'
    end
  end

  def current_station
    @route.stations[@station_index] unless @route.nil?
  end

  def previous_station
    if @station_index != 0
      @route.stations[@station_index - 1]
    else
      what_station
    end
  end

  def next_station
    if what_station != @route.stations.last
      @route.stations[@station_index + 1]
    else
      what_station
    end
  end

  protected

  # если будет вызываться этот метод, то поезд будет проскакивать через станции
  def go_to_station(index = 0)
    current_station.send_train(self)
    @route.stations[index].accept_train(self)
    @station_index = index
  end
end
