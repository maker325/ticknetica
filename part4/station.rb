require './train.rb'

class Station
  attr_reader :trains, :station_name

  def initialize(station)
    @station_name = station
    @trains = []
  end

  def accept(train)
    @trains.push(train)
  end

  def send(train)
    @trains.delete(train)
  end

  def get_trains(type = 'undefined')
    puts "List of all #{type} trains:" unless @trains.nil?
    puts @trains if type == 'undefined'
    @trains.each { |train| puts "##{train}" if train.type == type }
  end
end
