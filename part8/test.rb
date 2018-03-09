require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'train'
require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'passenger_train'


station1 = Station.new('MSK')
station2 = Station.new('KZN')

carriage1 = CargoCarriage.new('100')
carriage2 = CargoCarriage.new('150')

carriage3 = PassengerCarriage.new('50')
carriage4 = PassengerCarriage.new('100')

train = CargoTrain.new('123-45')
train2 = PassengerTrain.new('12345')

station1.accept_train(train)
station1.accept_train(train2)
station2.accept_train(train2)

train.hook_carriage(carriage1)
train.hook_carriage(carriage2)

train2.hook_carriage(carriage3)
train2.hook_carriage(carriage4)

block = Proc.new { |x| puts "Номер поезда #{x.number}. Тип поезда: #{x.type}. Всего вагонов: #{x.carriages.count}" }
block2 = Proc.new { |x| puts "Номер вагона #{x.number}. Тип вагона #{x.type}. Свободных мест: #{x.free_spaces}. Занятых мест: #{x.occupied_spaces}" }
block3 = Proc.new { |x| puts "Номер вагона #{x.number}. Тип вагона #{x.type}. Свободное пространство: #{x.free_spaces}м3. Занято грузом: #{x.occupied_spaces}м3" }


train2.block_trains_carriage(block2)
train.block_trains_carriage(block3)
station1.block_station_trains(block)
