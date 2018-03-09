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
    puts  '10. Просмотреть список станций.'
    puts  '11. Cписок поездов на станции.'
    puts  '12. Cписок вагонов поезда.'
    puts  '13. Занять место в вагоне.'
    puts  '14. выход'

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
        list_of_trains_on_station
      elsif choice == 12
        list_of_carriages_on_train
      elsif choice == 13
        take_places
      elsif choice == 14
        exit
      elsif choice == 0
        menu
      else
        puts 'Ошибка! Повторите ввод.'
      end
      puts 'Для выхода нажмите наберите 14, для вывода МЕНЮ - 0'
    end
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

  def new_train
    puts 'Введите номер поезда'
    number = gets.chomp.to_s
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
      puts 'Пожалуйста наберите 1 или 2 для выбора типа!'
      new_train
    end
  rescue RuntimeError => e
    puts e.message
    retry
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
      return
    end
    list_of_stations
    puts 'Выберете номер станции отправления'
    start_station_index = gets.to_i
    if @stations.include?(@stations[start_station_index - 1])
      start_station = @stations[start_station_index - 1]
    else
      puts 'Введите корректный номер станции.'
      return
    end
    list_of_stations
    puts 'Выберете номер станции назначения'
    finish_station_index = gets.to_i
    if @stations.include?(@stations[finish_station_index - 1])
      finish_station = @stations[finish_station_index - 1]
    else
      puts 'Введите корректный номер станции.'
      return
    end
    @routes << Route.new(start_station, finish_station)
    puts "маршрут от #{start_station.name} к #{finish_station.name} построен"
  rescue RuntimeError => e
    puts e.message
    retry
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
        puts 'Введите корректный номер станции.'
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
        puts 'Введите корректный номер станции.'
      else
        @routes[route_index - 1].remove(@stations[station_index - 1])
        puts "Станция #{@stations[station_index - 1].name} успешно удалена из маршрута № #{route_index}"
      end
    else
      puts 'ОШибка выбора дейтсвия, для выбора действия наберите 1 или 2'
    end
  end

  def list_of_trains
    @trains.each_with_index { |train, index| puts "#{index + 1}) Поезд №#{train.number} #{train.type}" }
  end

  def set_path
    check_trains
    puts 'Выберете индекс поезда для задания ему маршрута'
    list_of_trains
    train_index = gets.to_i
    if @trains.count >= train_index
      if @routes.empty?
        puts 'Нет маршрутов. Для начала создайте пожалуйста маршрут.'
        return
      else
        list_of_routes
        puts "Выберете номер маршрута для поезда #{@trains[train_index - 1].number}"
        route_choice = gets.to_i
        @trains[train_index - 1].set_route(@routes[route_choice - 1])
        puts "Маршрут № #{route_choice}   назначен Поезду #{@trains[train_index - 1].number}"
      end
    else
      puts 'Введите индекc пожалуйста корректно!'
    end
  end

  def new_carriage
    puts '1. Для создания грузового вагона'
    puts '2. Для создания пассажирского вагона'
    choice = gets.to_i
    if choice == 1
      puts 'Введите грузовой объём данного вагона:'
      scope = gets.to_i
      @carriages << CargoCarriage.new(scope)
      puts 'Добавлен грузовой вагон'
    elsif choice == 2
      puts 'Введите количество пассажирских мест данного вагона:'
      scope = gets.to_i
      @carriages << PassengerCarriage.new(scope)
      puts 'Добавлен пассажирский вагон'
    else
      puts 'Для добавления вагона наберите 1 или 2.'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def list_of_carriages
    @carriages.each_with_index { |carriage, index| print "#{index + 1}). #{carriage.type} " }
  end

  def check_trains
    if @trains.empty?
      puts 'для начала создайте поезд!:'
      menu
    end
  end

  def add_carriage
    check_trains
    if @carriages.empty?
      puts 'Для начала привезите вагоны!:'
      return
    end
    list_of_trains
    puts 'Введите индекс поезда для добавления вагонов'
    train_index = gets.to_i
    if @trains.count >= train_index
      puts 'Выберите вагон по номеру.'
      puts 'Список свободных вагонов:'
      list_of_carriages
      carriage_index = gets.to_i
      if carriage_index <= @carriages.count && @trains[train_index - 1].type == @carriages[carriage_index - 1].type
        @trains[train_index - 1].hook_carriage(@carriages[carriage_index - 1])
        @carriages.delete_at(carriage_index - 1)
        puts "Указанный вагон добавлен к поезду #{@trains[train_index - 1].number}"
      else
        puts 'Ошибка ввода, введите корректный индекс поезда или укажите верный тип вагона для данного типа поезда'
        return
      end
    else
      puts 'Введите корректный индекс поезда'
    end
  end

  def delete_carriage
    check_trains
    list_of_trains
    puts 'Введите индекс поезда для удаления вагонов'
    train_index = gets.to_i
    if @trains.count < train_index || @trains[train_index - 1].carriages.empty?
      puts 'нет вагонов для отцепления либо введен неверный индекс поезда.'
      return
    else
      puts 'Выберете вагон для отцепления:'
      @trains[train_index - 1].carriages.each_with_index { |_carriage, index| puts (index + 1).to_s }
      carriage_index = gets.to_i
      if @trains[train_index - 1].carriages.count >= carriage_index
        @carriages << @trains[train_index - 1].carriages[carriage_index - 1]
        @trains[train_index - 1].unhook_carriage(@trains[train_index - 1].carriages[carriage_index - 1])
        puts 'Вагон успешно отцеплен'
      else
        puts 'Все вагоны уже отцеплены или номер вагона указан неверно'
      end
    end
  end

  def move_train
    check_trains
    puts 'Введите индекс поезда для управления движением:'
    list_of_trains
    train_index = gets.to_i
    if @trains.count < train_index && @trains[train_index - 1].route.empty?
      puts 'Введен неверный номер поезда, либо маршрут у данного поезда не установлен'
      return
    else
      puts "Текущая станция #{@trains[train_index - 1].current_station.name}"
      puts '1. для движения назад'
      puts '2. для движения вперед'
      choice = gets.to_i
      if choice == 2
        @trains[train_index - 1].go_to_next_station
        unless @trains[train_index - 1].go_to_next_station.nil?
          puts 'Перемещение вперед прошло успешно'
        else
          puts 'Вы находитесь на последней станции'
        end
      elsif choice == 1
        @trains[train_index - 1].go_to_previous_station
        unless @trains[train_index - 1].go_to_previous_station.nil?
          puts 'Перемещение назад прошло успешно'
        else
          puts 'Вы находитесь на начальной станции'
        end
      else
        puts 'Для осуществления движения наберите 1 или 2.'
      end
    end
  end

  def list_of_trains_on_station
    if @stations.empty?
      puts 'Нет станций, добавьте'
    else
      list_of_stations
      puts 'Выберете номер станции для отображения текущих поездов на ней'
      station_index = gets.to_i
      if @stations[station_index - 1].trains.empty?
        puts "На станции #{@stations[station_index - 1].name} нет поездов."
      else
        block = Proc.new { |x| puts "Номер поезда #{x.number}. Тип поезда: #{x.type}. Всего вагонов: #{x.carriages.count}" }
        puts "На станции #{@stations[station_index - 1].name} находятся:"
        @stations[station_index - 1].block_station_trains(block)
      end
    end
  end

  def list_of_carriages_on_train
    check_trains
    puts 'Введите индекс поезда:'
    list_of_trains
    @train_index = gets.to_i
    if @trains.count >= @train_index
      block_pass = Proc.new { |x| puts "Номер вагона #{x.number}. Тип вагона #{x.type}. Свободных мест: #{x.free_spaces}. Занятых мест: #{x.occupied_spaces}" }
      block_cargo = Proc.new { |x| puts "Номер вагона #{x.number}. Тип вагона #{x.type}. Свободное пространство: #{x.free_spaces}м3. Занято грузом: #{x.occupied_spaces}м3" }
      puts "На поезде #{@trains[@train_index - 1].number} находятся:"
      if @trains[@train_index - 1].type == 'Cargo'
        @trains[@train_index - 1].block_trains_carriage(block_cargo)
      elsif @trains[@train_index - 1].type == 'Passenger'
        @trains[@train_index - 1].block_trains_carriage(block_pass)
      end
    else
      puts 'Введите индекс пожалуйста корректно!'
    end
  end

  def take_places
    list_of_carriages_on_train
    puts "Выберите номер вагона, чтобы занять место:"
    carriage_index = gets.to_i
    carriage = @trains[@train_index - 1].carriages[carriage_index-1]
    if carriage.type == 'Passenger'
      carriage.take_place
      puts "Место в вагоне №#{carriage.number} выбрано. Осталось мест в поезде: #{carriage.free_spaces}"
    elsif carriage.type == "Cargo"
      puts 'Введите объём, который хотите занять:'
      volume = gets.to_i
      carriage.take_place(volume)
      puts "#{volume}м3 было занято в вагоне №#{carriage.number}. Свободно: #{carriage.free_spaces}м3"
    end
  end

end

int = Interface.new
int.menu
