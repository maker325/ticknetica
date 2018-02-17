require './station.rb'
require './route.rb'

class Train
  attr_accessor :speed
  attr_reader :number_of_carriage, :stations, :type

  def initialize(number, number_of_carriage, type = 'pass')
    @number = number
    @type = type
    @number_of_carriage = number_of_carriage
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def hook
    @number_of_carriage += 1 if speed.zero?
  end

  def unhook
    @number_of_carriage -= 1 if speed.zero? && @number_of_carriage > 0
  end

  def set_route(route)
    @route = route
    @current_station = 0
    what_station.accept(self)
  end

  def go_to_next_station
    go_to_station(@current_station + 1) if what_station != @route.stations.last
  end

  def go_to_previous_station
    go_to_station(@current_station - 1) unless @route.nil? && @current_station == 0
  end

  def go_to_station(index = 0)
    what_station.send(self)
    @route.stations[index].accept(self)
    @current_station = index
  end

  def what_station
    @route.stations[@current_station] unless @route.nil?
  end

  def previous_station
    if @current_station != 0
      @route.stations[@current_station - 1]
    else
      what_station
    end
  end

  def next_station
    if what_station != @route.stations.last
      @route.stations[@current_station + 1]
    else
      what_station
    end
  end
end
