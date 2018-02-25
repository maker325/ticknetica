require_relative 'Route'
require_relative 'Station'
require_relative 'Carriage'

class Train
  attr_reader :stations, :speed, :carriage, :number

  def initialize(number)
    @number = number
    @speed = 0
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value if value < @speed
  end

  def hook_carriage(carriage)
    @carriage << [carriage]
  end

  def unhook_carriage(carriage)
    @carriage.delete(carriage)
  end

  def set_route(route)
    @route = route
    @station_index = 0
    current_station.accept_train(self)
  end

  def go_to_next_station
    go_to_station(@station_index + 1) if current_station != @route.stations.last
  end

  def go_to_previous_station
    go_to_station(@station_index - 1) unless @route.nil? && @station_index == 0
  end

  def current_station
    @route.stations[@station_index] unless @route.nil?
  end

  protected

  # если будет вызываться этот метод, то поезд будет проскакивать через станции
  def go_to_station(index = 0)
    current_station.send_train(self)
    @route.stations[index].accept_train(self)
    @station_index = index
  end
end
