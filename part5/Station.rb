require_relative 'CargoTrain'
require_relative 'PassengerTrain'

class Station
  attr_reader :trains, :name

  def initialize(station)
    @name = station
    @trains = []
  end

  def accept_train(train)
    @trains.push(train) if train.class == CargoTrain || train.class == PassengerTrain
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_trains
    @trains.each { |train| puts "Поезд № #{train.number}" }
  end
end
