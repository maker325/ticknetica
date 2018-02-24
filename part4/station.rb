require './train.rb'

class Station
  attr_reader :trains, :name

  def initialize(station)
    @name = station
    @trains = []
  end

  def accept(train)
    @trains.push(train)
  end

  def send(train)
    @trains.delete(train)
  end

  def get_trains(type = 'undefined')
    return @trains if type == 'undefined'
    @trains.select { |train| "##{train}" if train.type == type }
  end
end
