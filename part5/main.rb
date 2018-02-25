require_relative 'CargoCarriage'
require_relative 'CargoTrain'
require_relative 'PassengerCarriage'
require_relative 'PassengerTrain'
require_relative 'Route'
require_relative 'Station'
require_relative 'Carriage'
require_relative 'Train'

class Interface
  def initialize
    @trains = []
    @stations = []
    @carriages = []
    @routes = []
  end

  def menu
    puts  'Выберите пункт из меню:'
    puts  '1. Создать станцию.'
    puts  '2. Создать поезд.'
    puts  '3. Создать маршрут.'
    puts  '4. Редактировать маршрут.'
    puts  '5. Назначить маршрут поезду.'
    puts  '6. Добавить новый вагон.'
    puts  '7. Добавить вагоны к поезду.'
    puts  '8. Отцепить вагоны от поезда.'
    puts  '9. Переместить поезд по маршруту вперед или назад.'
    puts  '10. Просмотреть список станций'
    puts  '11. список поездов на станции.'
    puts  '12. выход'

    loop do
      choice = gets.chomp.to_i
      if choice == 1
        new_station
      elsif choice == 2
        new_train
      elsif choice == 3
        new_route
      elsif choice == 4
        edit_route
      elsif choice == 5
        set_path
      elsif choice == 6
        new_carriage
      elsif choice == 7
        add_carriage
      elsif choice == 8
        delete_carriage
      elsif choice == 9
        move_train
      elsif choice == 10
        list_of_stations
      elsif choice == 11
        list_of_trains
      elsif choice == 12
        exit
      elsif choice == 0
        menu
      else
        puts 'Ошибка! Повторите ввод.'
      end
      puts 'Для выхода нажмите наберите 12, для вывода МЕНЮ - 0'
    end
  end

  def new_station
    puts 'Введите название новой станции'
    name = gets.chomp.to_s
    @stations << Station.new(name)
    puts "Станция #{name} добавлена"
  end

  def new_train
    puts 'Введите номер поезда'
    number = gets.chomp.to_i
    puts 'Выберите тип поезда:'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    type = gets.chomp.to_i
    if type == 1
      @trains << PassengerTrain.new(number)
      puts "Пассажирский поезд #{number} успешно добавлен!"
    elsif type == 2
      @trains << CargoTrain.new(number)
      puts "Грузовой поезд #{number} успешно добавлен!"
    else
      puts 'Ошибка, повторите попытку ещё раз!'
      new_train
    end
  end

  def list_of_stations
    if @stations.empty?
      puts 'Cтанции не созданы'
    else
      puts 'список всех станций:'
      @stations.each_with_index { |stat, index| puts "Станция №#{index + 1}: #{stat.name}" }
    end
  end

  def new_route
    puts 'Создайте маршрут'
    if @stations.count < 2
      puts 'для создания маршрута необходимо минимум 2 станции! Создайте станцию:'
      new_station
    end
    list_of_stations
    puts 'Выберете номер станции отправления'
    start_station_index = gets.to_i
    if @stations.include?(@stations[start_station_index - 1])
      start_station = @stations[start_station_index - 1]
    else
      puts 'Ошибка! Попробуйте еще.'
      return
    end
    list_of_stations
    puts 'Выберете номер станции назначения'
    finish_station_index = gets.to_i
    if @stations.include?(@stations[finish_station_index - 1]) && (start_station != @stations[finish_station_index - 1])
      finish_station = @stations[finish_station_index - 1]
    else
      puts 'Ошибка! Попробуйте еще.'
      return
    end
    @routes << Route.new(start_station, finish_station)
    puts "маршрут от #{start_station.name} к #{finish_station.name} построен"
  end

  def list_of_routes
    if @routes.empty?
      puts 'Отсутствуют маршруты для изменения'
    else
      puts 'Список всех маршрутов:'
      @routes.each_with_index { |route, index| puts "№#{index + 1} Маршрут #{route.get_stations} " }
    end
  end

  def edit_route
    puts 'Введите номер маршрута для редактирования'
    list_of_routes
    route_index = gets.to_i
    puts 'Выберите действие:'
    puts '1. Добавить станцию'
    puts '2. Удалить станцию'
    action = gets.to_i
    if action == 1
      puts 'Введите номер станции, которую хотите добавить в выбранный маршрут'
      list_of_stations
      station_index = gets.to_i
      if station_index > @stations.count
        puts 'ОШибка! Повторите ввод!'
      else
        @routes[route_index - 1].add(@stations[station_index - 1])
        puts "Станция #{@stations[station_index - 1].name} успешно добавлена к маршруту № #{route_index}"
      end
    elsif action == 2
      puts "список станций на данном маршруте: #{@routes[route_index - 1].get_stations}!"
      puts 'Введите номер станции по списку ниже, которую хотите удалить из данного маршрута'
      list_of_stations
      station_index = gets.to_i
      if station_index > @stations.count
        puts 'ОШибка! Повторите ввод!'
      else
        @routes[route_index - 1].remove(@stations[station_index - 1])
        puts "Станция #{@stations[station_index - 1].name} успешно удалена из маршрута № #{route_index}"
      end
    else
      puts 'ОШибка выбора дейтсвия'
    end
  end

  def list_of_trains
    @trains.each_with_index { |train, index| puts "#{index + 1}) Поезд №#{train.number} #{train.type}" }
  end

  def set_path
    if @trains.empty?
      puts 'Для установки маршрута создайте поезд!'
      new_train
    end
    puts 'Выберете индекс поезда для задания ему маршрута'
    list_of_trains
    train_index = gets.to_i
    if trains.count >= train_index
      if @routes.empty?
        puts 'Нет маршрутов. Создайте:'
        new_route
      else
        routes_list
        puts "Выберете номер маршрута для поезда #{@trains[train_index - 1].number}"
        route_choice = gets.to_i
        @trains[train_index - 1].set_route(@routes[route_choice - 1])
        puts "Маршрут № #{route_choice}   назначен Поезду #{@trains[train_index - 1].number}"
      end
    else
      puts 'Ошибка! Повторите ввод!'
      set_path
    end
  end

  def new_carriage
    puts '1. Для создания грузового вагона'
    puts '2. Для создания пассажирского вагона'
    choice = gets.to_i
    if choice == 1
      @carriages << CargoCarriage.new
      puts 'Добавлен грузовой вагон'
    elsif choice == 2
      @carriages << PassengerCarriage.new
      puts 'Добавлен пассажирский вагон'
    else
      puts 'Ошибка ввода, повторите попытку'
      new_carriage
    end
  end

  def list_of_carriages
    @carriages.each_with_index { |carriage, index| print "#{index + 1}). #{carriage.type} " }
  end

  def add_carriage
    if @trains.empty?
      puts 'для начала создайте поезд!:'
      new_train
    end
    if @carriages.empty?
      puts 'Для начала привезите вагоны!:'
      new_carriage
    end
    puts 'Введите индекс поезда для добавления вагонов'
    list_of_trains
    train_index = gets.to_i
    if @trains.count >= train_index
      puts 'Выберите вагон по номеру.'
      puts 'Список свободных вагонов:'
      list_of_carriages
      carriage_index = gets.to_i
      if carriage_index <= @carriages.count && @trains[train_index - 1].type == @carriages[carriage_index - 1].type
        @trains[train_index - 1].hook_carriage[@carriages[carriage_index - 1]]
        @carriages.delete_at(carriage_index - 1)
        puts "#{@carriages[carriage_index - 1].type} вагон добавлен к поезду #{@trains[train_index - 1]}"
      else
        puts 'Ошибка ввода, повторите ещё раз'
        add_carriage
      end
    else
      puts 'Ошибка ввода'
      return
    end
  end
end

int = Interface.new
int.menu
