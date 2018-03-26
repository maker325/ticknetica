require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acсessors'

class Station
  include InstanceCounter
  include Validation
  include Aсcessors

  STATION_FORMAT = /^[a-zA-Zа-яА-Я]{1}[a-zA-Zа-яА-Я0-9]+$/

  attr_reader :trains, :name
  validate :name, :presence
  validate :name, :format, STATION_FORMAT

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(station)
    @name = station
    validate!
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

  def show_trains
    @trains.each { |train| puts "Поезд № #{train.number}" }
  end

  def each_station(block)
    @trains.each { |train| block.call(train) }
  end
end
