require_relative 'station'
require_relative 'validation'

class Route
  attr_reader :stations
  include InstanceCounter
  include Validation

  def initialize(start, finish)
    @stations = [start, finish]
    validate!
    register_instance
  end

  def add(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove(station)
    @stations.delete(station) unless [@stations[0], @stations[-1]].include?(station)
  end

  def show_stations
    @stations.each_with_index { |station, index| print "#{index + 1}) #{station.name}; " }
  end

  protected

  def validate!
    unless @stations.first.is_a?(Station) && @stations.last.is_a?(Station)
      raise 'Маршрут должен состоять из объектов класса Station!'
    end
    raise 'Маршрут не может идти из указанной станции в эту же станцию!' if @stations.first == @stations.last
    true
  end
end
