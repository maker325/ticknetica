require './station.rb'
require './route.rb'

class Train
  attr_reader :number_of_carriages, :stations, :type, :speed

  def initialize(number, number_of_carriages, type = 'pass')
    @number = number
    @type = type
    @number_of_carriages = number_of_carriages
    @speed = 0
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value if value < @speed
  end

  def hook
    @number_of_carriages += 1 if speed.zero?
  end

  def unhook
    @number_of_carriages -= 1 if speed.zero? && @number_of_carriages > 0
  end

  def set_route(route)
    @route = route
    @station_index = 0
    what_station.accept(self)
  end

  def go_to_next_station
    go_to_station(@station_index + 1) if what_station != @route.stations.last
  end

  def go_to_previous_station
    go_to_station(@station_index - 1) unless @route.nil? && @station_index == 0
  end

  def go_to_station(index = 0)
    what_station.send(self)
    @route.stations[index].accept(self)
    @station_index = index
  end

  def what_station
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
end
