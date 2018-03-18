require_relative 'main'

class Menu
  def initialize(main)
    @main = main
  end

  def menu
    show_menu
    choice = gets.chomp.to_i
    exit if choice == 4
    send ACTIONS_MENU[choice] if ACTIONS_MENU[choice]
    puts 'Выберите пункты от 1 до 4.'
    menu
  end

  protected

  ACTIONS_MENU = {
    1 => :create_objects,
    2 => :objects_action,
    3 => :list_of_objects
  }.freeze

  ACTIONS_CREATE_OBJECTS = {
    1 => :new_station,
    2 => :new_train_show,
    3 => :new_route_show,
    4 => :edit_route_show,
    5 => :new_carriage
  }.freeze

  ACTIONS_OBJECTS_ACTIONS = {
    1 => :set_path,
    2 => :add_carriage,
    3 => :delete_carriage,
    4 => :move_train,
    5 => :take_places
  }.freeze

  ACTIONS_LIST_OF_OBJECTS = {
    1 => :list_of_stations,
    2 => :list_of_trains_on_station,
    3 => :list_of_carriages_on_train,
    4 => :list_of_routes
  }.freeze

  def show_menu
    puts 'Выберите пункт из меню:'
    puts '1. Cоздать объекты.'
    puts '2. Действия с объектами.'
    puts '3. Просмотр объектов.'
    puts '4. Выход.'
  end

  def create_objects
    show_create_objects
    choice = gets.chomp.to_i
    return if choice == 6
    @main.send ACTIONS_CREATE_OBJECTS[choice] if ACTIONS_CREATE_OBJECTS[choice]
    puts 'Выберите пункты от 1 до 6.'
    create_objects
  end

  def show_create_objects
    puts '1. Создать станцию.'
    puts '2. Создать поезд.'
    puts '3. Создать маршрут.'
    puts '4. Редактировать маршрут.'
    puts '5. Добавить новый вагон.'
    puts '6. Основное меню.'
  end

  def objects_action
    show_objects_action
    choice = gets.chomp.to_i
    return if choice == 6
    @main.send ACTIONS_OBJECTS_ACTIONS[choice] if ACTIONS_OBJECTS_ACTIONS[choice]
    puts 'Выберите пункты от 1 до 6.'
    objects_action
  end

  def show_objects_action
    puts '1. Назначить маршрут поезду.'
    puts '2. Добавить вагоны к поезду.'
    puts '3. Отцепить вагоны от поезда.'
    puts '4. Переместить поезд по маршруту вперед или назад.'
    puts '5. Занять место в вагоне.'
    puts '6. Основное меню.'
  end

  def list_of_objects
    show_list_of_objects
    choice = gets.chomp.to_i
    return if choice == 5
    @main.send ACTIONS_LIST_OF_OBJECTS[choice] if ACTIONS_LIST_OF_OBJECTS[choice]
    puts 'Выберите пункты от 1 до .'
    list_of_objects
  end

  def show_list_of_objects
    puts '1. Список станций.'
    puts '2. Cписок поездов на станции.'
    puts '3. Cписок вагонов поезда.'
    puts '4. Список маршрутов.'
    puts '5. Основное меню.'
  end
end

int = Interface.new
menu = Menu.new(int)
menu.menu
