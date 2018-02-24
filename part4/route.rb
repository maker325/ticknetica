require './station.rb'

class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station) unless [@stations[0], @stations[-1]].include?(station)
  end

  def get_stations
    @stations.each_with_index { |name, index| puts "#{index += 1}) #{name};" }
  end
end
