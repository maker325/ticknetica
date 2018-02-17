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
    station_index = @stations.index(station)
    @stations.delete(station) if station_index != @stations.size - 1 && station_index != 0
  end

  def get_stations
    @stations.each_with_index { |name, index| puts "#{index += 1}) #{name};" }
  end
end
