require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'instance_counter'
require_relative 'validation'

class Station
  attr_reader :trains, :name
  @@stations = []
  include InstanceCounter
  include Validation
  STATION_FORMAT = /^[a-zA-Zа-яА-Я]{1}[a-zA-Zа-яА-Я0-9]+$/

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

  def get_trains
    @trains.each { |train| puts "Поезд № #{train.number}" }
  end

  protected

  def validate!
    raise 'Имя не может быть пустым' if station.nil?
    raise 'Имя не может быть короче 2 символов' if station.length < 2
    raise 'Введенное имя некорректно, Должно быть: первый символ буква, последующие цифры или буквы' if name !~ NAME_FORMAT
    true
  end
end
