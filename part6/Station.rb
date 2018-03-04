require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'InstanceCounter'

class Station
  attr_reader :trains, :name
  @@stations = []
  include InstanceCounter

  def self.all
    @@stations
  end

  def initialize(station)
    @name = station
    @trains = []
    @@stations << self
    register_instance
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
