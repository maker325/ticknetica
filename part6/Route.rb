require_relative 'Station'

class Route
  attr_reader :stations
  include InstanceCounter

  def initialize(start, finish)
    @stations = [start, finish]
    register_instance
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    @stations.delete(station) unless [@stations[0], @stations[-1]].include?(station)
  end

  def get_stations
    @stations.each_with_index { |station, index| print "#{index += 1}) #{station.name}; " }
  end
end
