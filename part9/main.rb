require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'train'
require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'passenger_train'

class Interface
  def initialize
    @trains = []
    @stations = []
    @carriages = []
    @routes = []
  end

  def new_station
    puts 'Введите название новой станции'
    name = gets.chomp.to_s
    @stations << Station.new(name)
    puts "Станция #{name} добавлена"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def new_train_show
    puts 'Введите номер поезда'
    number = gets.chomp.to_s
    puts 'Выберите тип поезда:'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    type = gets.chomp.to_i
    return puts 'Пожалуйста наберите 1 или 2 для выбора типа!' unless (1..2).cover?(type)
    new_train_do(number, type)
  end

  def new_route_show
    str = 'Для создания маршрута необходимо минимум 2 станции! Создайте станцию!'
    return puts str if @stations.count < 2
    new_route_start
    new_route_finish
    @routes << Route.new(@start_station, @finish_station)
    puts "Маршрут от #{@start_station.name} к #{@finish_station.name} построен."
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def edit_route_show
    return unless chouse_route
    puts 'Выберите действие:'
    puts '1. Добавить станцию'
    puts '2. Удалить станцию'
    action = gets.to_i
    return puts 'Наберите 1 или 2 для выбора действия!' unless (1..2).cover?(action)
    edit_route_add(@route_index) if action == 1
    edit_route_remove(@route_index) if action == 2
  end

  def new_carriage
    puts '1. Для создания грузового вагона'
    puts '2. Для создания пассажирского вагона'
    choice = gets.to_i
    return puts 'Для добавления вагона наберите 1 или 2!' unless (1..2).cover?(choice)
    new_carriage_cargo if choice == 1
    new_carriage_pass if choice == 2
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def set_path
    return unless chouse_train
    return unless chouse_route
    @trains[@train_index].paste_route(@routes[@route_index])
    puts "Маршрут № #{@route_index + 1} назначен Поезду #{@trains[@train_index].number}"
  end

  def add_carriage
    chouse_train
    chouse_carriage
    bulean = @trains[@train_index].type == @carriages[@carriage_index].type
    return puts 'Выберете соответствующий тип вагона!' unless bulean
    @trains[@train_index].hook_carriage(@carriages[@carriage_index])
    @carriages.delete_at(@carriage_index)
    puts 'Вагон добавлен к поезду'
  end

  def delete_carriage
    return unless chouse_train
    return unless chouse_carriage(@train[@train_index].carriages)
    @carriages << @trains[@train_index].carriages[@carriage_index]
    @trains[@train_index].unhook_carriage(@trains[@train_index].carriages[@carriage_index])
    puts 'Вагон успешно отцеплен.'
  end

  def move_train
    return unless chouse_train
    return puts 'Задайте маршрут для поезда!' if @trains[@train_index].route.empty?
    puts '1. для движения назад;  2. для движения вперед.'
    choice = gets.to_i
    return puts 'Для движения наберите 1 или 2!' unless (1..2).cover?(choice)
    move_train_forward if choice == 2
    move_train_backward if choice == 1
  end

  def take_places
    list_of_carriages_on_train
    chouse_carriage(@train[@train_index].carriages)
    str = 'Недостаточно места'
    carriage = @trains[@train_index].carriages[@carriage_index]
    take_places_pass(str, carriage) if carriage.type == 'Passenger'
    take_places_cargo(str, carriage) if carriage.type == 'Cargo'
  end

  def list_of_stations(stations = @stations)
    stations.each_with_index { |s, i| puts "Станция №#{i + 1}: #{s.name}" }
  end

  def list_of_carriages(carriages = @carriages)
    carriages.each_with_index { |c, i| puts "#{i + 1}). #{c.type}" }
  end

  def list_of_trains
    @trains.each_with_index { |t, i| puts "#{i + 1}) Поезд №#{t.number} #{t.type}" }
  end

  def list_of_routes
    @routes.each_with_index { |r, i| puts "№#{i + 1} Маршрут #{r.show_stations} " }
  end

  def list_of_carriages_on_train
    return unless chouse_train
    block_pass = proc { |x| puts "Номер вагона #{x.number}. Тип #{x.type}. Свободных мест: #{x.free_spaces}. Занято: #{x.occupied_spaces}" }
    block_cargo = proc { |x| puts "Номер вагона #{x.number}. Тип #{x.type}. Свободное пространство: #{x.free_spaces}м3. Занято: #{x.occupied_spaces}м3" }
    puts "На поезде #{@trains[@train_index].number} находятся:"
    @trains[@train_index].each_train(block_cargo) if @trains[@train_index].type == 'Cargo'
    @trains[@train_index].each_train(block_pass) if @trains[@train_index].type == 'Passenger'
  end

  def list_of_trains_on_station
    return unless chouse_train
    if @stations[@station_index].trains.empty?
      puts "На станции #{@stations[@station_index].name} нет поездов."
    else
      block = proc { |x| puts "Номер поезда #{x.number}. Тип: #{x.type}.Вагонов: #{x.carriages.count}" }
      puts "На станции #{@stations[@station_index].name} находятся:"
      @stations[@station_index].each_station(block)
    end
  end

  protected

  def new_train_do(number, type)
    if type == 1
      @trains << PassengerTrain.new(number)
      puts "Пассажирский поезд #{number} успешно добавлен!"
    elsif type == 2
      @trains << CargoTrain.new(number)
      puts "Грузовой поезд #{number} успешно добавлен!"
    end
  rescue RuntimeError => e
    puts e.message
  end

  def new_route_start
    puts 'Выберете номер станции отправления'
    list_of_stations
    start_station_index = gets.to_i
    return puts 'Ввод некорректен!' if start_station_index.zero?
    if @stations.include?(@stations[start_station_index - 1])
      @start_station = @stations[start_station_index - 1]
    else
      puts 'Введите корректный номер станции.'
      new_route_start
    end
  end

  def new_route_finish
    puts 'Выберете номер станции назначения'
    list_of_stations
    finish_station_index = gets.to_i
    return puts 'Ввод некорректен!' if finish_station_index.zero?
    if @stations.include?(@stations[finish_station_index - 1])
      @finish_station = @stations[finish_station_index - 1]
    else
      puts 'Введите корректный номер станции.'
      new_route_finish
    end
  end

  def edit_route_add(route_index)
    puts 'Введите номер станции, которую хотите добавить в выбранный маршрут'
    chouse_station
    str1 = "#{@stations[@station_index].name} к маршруту добавлена."
    str2 = 'Операция не выполнена!'
    puts @routes[route_index].add(@stations[@station_index]) ? str1 : str2
  end

  def edit_route_remove(route_index)
    puts 'Введите номер станции по списку, которую хотите удалить из маршрута'
    chouse_station(@routes[route_index].stations)
    station = @routes[route_index].stations[@station_index]
    str1 = "#{station.name} удалена из маршрута."
    str2 = 'Операция не выполнена!'
    puts @routes[route_index].remove(station) ? str1 : str2
  end

  def chouse_route
    if @routes.empty?
      puts 'Для начала создайте маршрут!'
      return false
    end
    list_of_routes
    puts 'Введите индекс маршрута.'
    index = gets.to_i
    bulean = (index <= @routes.count && index != 0)
    puts 'Введите индекс корректно!' unless bulean
    bulean ? @route_index = index - 1 : false
  end

  def chouse_train
    if @trains.empty?
      puts 'Для начала создайте поезд!'
      return false
    end
    list_of_trains
    puts 'Введите индекс поезда.'
    index = gets.to_i
    bulean = (index <= @trains.count && index != 0)
    puts 'Введите индекс корректно!' unless bulean
    bulean ? @train_index = index - 1 : false
  end

  def chouse_station(stations = @stations)
    if stations.empty?
      puts 'Для начала создайте станции!'
      return false
    end
    list_of_stations(stations)
    puts 'Введите индекс станции.'
    index = gets.to_i
    bulean = (index <= stations.count && index != 0)
    puts 'Введите индекс корректно!' unless bulean
    bulean ? @station_index = index - 1 : false
  end

  def chouse_carriage(carriages = @carriages)
    if carriages.empty?
      puts 'Вагоны отсутсвуют!'
      return false
    end
    list_of_carriages(carriages)
    puts 'Введите индекс вагона.'
    index = gets.to_i
    bulean = (index <= carriages.count && index != 0)
    puts 'Введите индекс корректно!' unless bulean
    bulean ? @carriage_index = index - 1 : false
  end

  def new_carriage_cargo
    puts 'Введите грузовой объём данного вагона:'
    scope = gets.to_i
    return puts 'Новый вагон не может быть полным!' if scope.zero?
    @carriages << CargoCarriage.new(scope)
    puts 'Добавлен грузовой вагон.'
  end

  def new_carriage_pass
    puts 'Введите количество пассажирских мест данного вагона:'
    scope = gets.to_i
    return puts 'Новый вагон не может быть полным!' if scope.zero?
    @carriages << PassengerCarriage.new(scope)
    puts 'Добавлен пассажирский вагон.'
  end

  def move_train_forward
    puts @trains[@train_index].go_to_next_station ? 'успешно' : 'Вы на последней станции'
  end

  def move_train_backward
    puts @trains[@train_index].go_to_previous_station ? 'успешно' : 'Вы на начальной станции'
  end

  def take_places_pass(str, carriage)
    str1 = "Место в вагоне №#{carriage.number} выбрано. Свободно: #{carriage.free_spaces}"
    p carriage.take_place ? str1 : str
  end

  def take_places_cargo(str, carriage)
    puts 'Введите объём, который хотите занять:'
    volume = gets.to_i
    str2 = "#{volume}м3 занято в №#{carriage.number}. Свободно: #{carriage.free_spaces}м3"
    p carriage.take_place(volume) ? str2 : str
  end
end
