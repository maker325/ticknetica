require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  STATION_FORMAT = /^[a-zA-Zа-яА-Я]{1}[a-zA-Zа-яА-Я0-9]+$/
  attr_reader :trains, :name
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

  protected

  def validate!
    raise 'Имя не может быть пустым' if @name.nil?
    raise 'Имя не может быть короче 2 символов' if @name.length < 2
    str = 'Ввод некорректен. ФОРМАТ: первый символ буква, последующие цифры или буквы'
    raise str if @name !~ STATION_FORMAT
    true
  end
end
