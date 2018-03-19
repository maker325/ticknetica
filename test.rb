def list_of_trains_on_station
  return unless trains_on_stations
  block = proc { |x| puts x.info }
  puts "На станции #{@stations[@station_index].name} находятся:"
  @stations[@station_index].each_station(block)
end

def trains_on_stations
  return unless chouse_station
  str = "На станции #{@stations[@station_index].name} нет поездов."
  puts  str if @stations[@station_index].trains.empty?
end
