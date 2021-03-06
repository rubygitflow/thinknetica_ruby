require_relative 'library'
require_relative 'validator'
require_relative 'instance_counter'

require_relative 'station'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'

require_relative 'seeds'

class TextInterface
  # Здесь общая реализация текстового интерфейса программы
  include Library
  include Seeds

  APPLICATION_NAME = 'Управление железной дорогой'

  attr_reader  :menu_input,  :station_menu_input,  :menu_cursor  

  # Меню диалогового интерфейса программы 
  # Разрешаем изменять его в наследниках класса
  def initialize

    # Засев данных для тестов программы
    init_data

    @menu_input = { 
      1 => {  
        name: 'Станция',
        navigate: { 
          1 => {
            name: 'Создать',
            link: :add_station
          },
          2 => {
            name: 'Показать весь список',
            link: :station_list_menu
          },
          3 => {
            name: 'Вернуться к главному меню',
            link: :goto_top_main_menu
          }
        } 
      }, 
      2 => {  
        name: 'Маршрут',
        navigate: { 
          1 => {
            name: 'Создать',
            link: :add_route
          },
          2 => {
            name: 'Добавить станцию к маршруту',
            link: :add_station_to_route
          },
          3 => {
            name: 'Удалить станцию из маршрута',
            link: :delete_station_from_route
          },
          4 => {
            name: 'Вернуться к главному меню',
            link: :goto_top_main_menu
          }
        } 
      }, 
      3 => {  
        name: 'Поезд',
        navigate: { 
          1 => {
            name: 'Создать и назначить маршрут',
            link: :add_train
          },
          2 => {
            name: 'Отправить по маршруту вперед',
            link: :move_forward
          },
          3 => {
            name: 'Отправить по маршруту назад',
            link: :move_backward
          },
          4 => {
            name: 'Прицепить вагон',
            link: :add_wagon
          },
          5 => {
            name: 'Отцепить вагон',
            link: :detach_wagon
          },
          6 => {
            name: 'Вернуться к главному меню',
            link: :goto_top_main_menu
          }
        } 
      }, 
      4 => {  
        name: 'Пассажир',
        navigate: { 
          1 => {
            name: 'Посадка',
            link: :boarding_passenger
          },
          2 => {
            name: 'Высадка',
            link: :unboarding_passenger
          },
          3 => {
            name: 'Вернуться к главному меню',
            link: :goto_top_main_menu
          }
        } 
      },
      5 => {  
        name: 'Груз',
        navigate: { 
          1 => {
            name: 'Загрузка',
            link: :loading_cargo
          },
          2 => {
            name: 'Выгрузка',
            link: :unloading_cargo
          },
          3 => {
            name: 'Вернуться к главному меню',
            link: :goto_top_main_menu
          }
        } 
      },
      6 => {  
        name: 'Выйти из программы',
        link: :exit
      }
    }  

    @station_menu_input = { 
      1 => {  
        name: 'Создать грузовой вагон',
        link: :add_cargo_wagon
      }, 
      2 => {  
        name: 'Создать пассажирский вагон',
        link: :add_passenger_wagon
      }, 
      3 => {  
        name: 'Показать статистику по грузовым вагонам на запасных путях',
        link: :show_cargo_wagons
      }, 
      4 => {  
        name: 'Показать статистику по пассажирским вагонам на запасных путях',
        link: :show_passenger_wagons
      }, 
      5 => {  
        name: 'Показать статистику по грузовым поездам',
        link: :show_cargo_trains
      }, 
      6 => {  
        name: 'Показать статистику по пассажирским поездам',
        link: :show_passenger_trains
      }, 
      7 => {  
        name: 'Вернуться к списку станций',
        link: :station_list_menu
      }
    }

    @menu_cursor = []
    # @station_list = []
    # @route_list = []
    # @passenger_train_list = []
    # @cargo_train_list = []
  end

  # Конструктор главного диалогового интерфейса программы 
  # Допускаем его вызов из объекта программы
  def main_menu
    menu_text = construct_main_menu_list
    breadcrumbs_text = construct_breadcrumbs_text
    put_breadcrumbs(breadcrumbs_text)
    put_main_menu_list(menu_text)
    put_main_menu_navigate_notice
    case_main_menu
  end

  protected
  # Здесь частная реализация логики работы текстового интерфейса программы

  attr_accessor  :breadcrumbs,  :local_menu_object,  :current_station

  def put_breadcrumbs(breadcrumbs_text)
    puts breadcrumbs_text
  end

  def put_main_menu_list(menu_text)
    puts menu_text
  end

  def put_main_menu_navigate_notice
    print "Введите номер пункта из меню и нажмите Enter: "
  end

  def case_main_menu
    navigate_to = gets.to_i
    size = @local_menu_object.length
    
    if navigate_to > size || navigate_to < 1
      repeat_input_from_main_menu(navigate_to)
    else
      element = @local_menu_object.dig(navigate_to, :link)
      if element.nil?
        @menu_cursor << navigate_to
        main_menu
      else
        send(element)
      end
    end
  end

  def station_list_menu
    breadcrumbs_text = "\n" + APPLICATION_NAME + "/" + breadcrumbs * "/" + "/Весь список" + ":"
    put_breadcrumbs(breadcrumbs_text)
    if construct_station_list
      put_station_list_navigate_notice
      case_station_list_menu
    else
      main_menu
    end
  end

  def put_station_list_navigate_notice
    print "Введите номер станции и нажмите Enter: "
  end

  def case_station_list_menu
    navigate_to = gets.to_i
    exit_menu_index = Station.instances_amount + 1
    
    if navigate_to > exit_menu_index || navigate_to < 1
      repeat_input_from_station_list_menu(navigate_to, exit_menu_index)
    elsif navigate_to == exit_menu_index
      main_menu
    else
      station_menu(navigate_to - 1)
    end
  end

  def case_station_menu
    navigate_to = gets.to_i
    size = @station_menu_input.length
    
    if navigate_to > size || navigate_to < 1
      repeat_input_from_station_menu(navigate_to, size - 1)
    else
      send(@station_menu_input.dig(navigate_to, :link))
    end
  end

  def station_menu(station_index)
    breadcrumbs_text = "\n" + APPLICATION_NAME + "/" + breadcrumbs * "/" + "/" + 
                       Station.all[station_index].name + ":"
    put_breadcrumbs(breadcrumbs_text)
    menu_text = construct_station_menu_list
    put_main_menu_list(menu_text)
    put_main_menu_navigate_notice
    @current_station = station_index
    case_station_menu
  end

  private
  # Здесь реализация различных дополнительных конструкторов в частной логике работы текстового интерфейса программы

  def construct_breadcrumbs_text    
    if @menu_cursor.empty?
      "\n" + APPLICATION_NAME
    else
      "\n" + APPLICATION_NAME + "/" + breadcrumbs * "/" + ":"  #  breadcrumbs.join("/")
    end
  end

  def goto_top_main_menu
    @menu_cursor = []
    @local_menu_object = @menu_input.clone
    main_menu
  end

  def take_local_menu_object(menu_item, menu_cursor_item)
    size = menu_cursor_item.length - 1
    navigate_to = menu_cursor_item[0].to_i
    if size > 0 
      @breadcrumbs << menu_item.dig(navigate_to, :name)
      return take_local_menu_object(menu_item.dig(navigate_to, :navigate), menu_cursor_item[-(size), size])
    elsif size == 0
      @breadcrumbs << menu_item.dig(navigate_to, :name)
      if menu_item.dig(navigate_to, :link).nil?
        return menu_item.dig(navigate_to, :navigate)
      else
        return menu_item.dig(navigate_to, :link)
      end
    else
      # осторожно с алгоритмом, возможно проваливание сюда 
      # тогда @breadcrumbs не должно меняться
    end
  end

  def construct_main_menu_list
    @breadcrumbs = []
    @local_menu_object = take_local_menu_object(@menu_input, @menu_cursor)
    if local_menu_object.nil?
      @menu_cursor = []
      @local_menu_object = @menu_input.clone
      s = ''
      @menu_input.each_pair{|key, value| s << key.to_s + '. ' + value.fetch(:name) + "\n"}
      s
    else
      s = ''
      @local_menu_object.each_pair{|key, value| s << key.to_s + '. ' + value.fetch(:name) + "\n"}
      s
    end
  end

  def repeat_input_from_main_menu(navigate_to)
    size = @local_menu_object.length
    puts "Выбрано недопустимое значение #{navigate_to}"
    print "Повторите ввод числа в интервале [1 , #{size}]: "

    case_main_menu
  end

  def add_station
    print "Введите название станции: "
    begin
      attempt ||= 0
      name = gets.strip
      if Station.all.detect { |station| station.name == name }
        puts "Станция #{name.inspect} уже существует."
      else 
        Station.new(name)
        puts "Станция #{name.inspect} добавлена"
        Station.sort
      end
    rescue RuntimeError => e
      puts "Error: #{e.message}"
      puts "Allowed characters (min=3): a-z, а-я, 0-9, пробел и дефис"
      print 'Повторите ввод названия станции: '
      retry if (attempt += 1) < 3
    end

    main_menu
  end

  def construct_station_list
    if Station.all.empty?
      puts "Список станций пустой"
      false
    else
      station_names_list = []
      Station.all.each_with_index{|station, index| station_names_list << [index+1 , station.name]}
      station_names_list_text = station_names_list.map{|item| item[0].to_s + '. ' + item[1].to_s}
      puts station_names_list_text * "\n" + "\n" + (Station.all.length + 1).to_s + ". Вернуться к меню 'Станция'"
      true
    end
  end

  def repeat_input_from_station_list_menu(navigate_to, exit_menu_index)
    puts "Выбрано недопустимое значение #{navigate_to}"
    print "Повторите ввод числа в интервале [1 , #{exit_menu_index}]: "

    case_station_list_menu
  end

  def construct_station_menu_list
    s = ''
    @station_menu_input.each_pair{|key, value| s << key.to_s + '. ' + value.fetch(:name) + "\n"}
    s
  end

  def repeat_input_from_station_menu(navigate_to, exit_menu_index)
    puts "Выбрано недопустимое значение #{navigate_to}"
    print "Повторите ввод числа в интервале [1 , #{exit_menu_index + 1}]: "

    case_station_menu
  end

  def input_add_cargo_wagon
    print "Введите полный объем вагона (целое число): "
    volume = gets.strip.to_i.abs
    size = @station_menu_input.length
    
    if volume == 0
      puts "В вагоне обязательно указывать количество мест больше нуля"
      input_add_cargo_wagon
    else
      Station.all[current_station].take_wagons(CargoWagon.new(volume))
    end
  end

  def add_cargo_wagon
    Station.all[current_station].take_wagons(CargoWagon.new)
    input_add_cargo_wagon
    puts "На запасные пути поставлен новый #{TrainTypeDescription.dig(:cargo, :name)} вагон с объемом #{Station.all[current_station].wagons_by_type(Cargo)[-1].max_volume}"
    puts "Вагонов на станции (тип #{TrainTypeDescription.dig(:cargo, :name)}): #{Station.all[current_station].wagons_by_type(Cargo).length}"
    station_menu(current_station)
  end

  def input_add_passenger_wagon
    print "Введите количество мест в вагоне: "
    places = gets.strip.to_i.abs
    size = @station_menu_input.length
    
    if places == 0
      puts "В вагоне обязательно указывать количество мест больше нуля"
      input_add_passenger_wagon
    else
      Station.all[current_station].take_wagons(PassengerWagon.new(places))
    end
  end

  def add_passenger_wagon
    input_add_passenger_wagon
    puts "На запасные пути поставлен новый #{TrainTypeDescription.dig(:passenger, :name)} вагон на #{Station.all[current_station].wagons_by_type(Passenger)[-1].max_seats} мест."
    puts "Вагонов на станции (тип #{TrainTypeDescription.dig(:passenger, :name)}): #{Station.all[current_station].wagons_by_type(Passenger).length}"
    station_menu(current_station)
  end

  def show_cargo_wagons
    wagons_amount = Station.all[current_station].wagons_by_type(Cargo).length
    puts "Вагонов на станции (тип #{TrainTypeDescription.dig(:cargo, :name)}): #{wagons_amount}"
    show_cargo_wagons_list(Station.all[current_station])
    station_menu(current_station)
  end

  def show_passenger_wagons
    wagons_amount = Station.all[current_station].wagons_by_type(Passenger).length
    puts "Вагонов на станции (тип #{TrainTypeDescription.dig(:passenger, :name)}): #{wagons_amount}"
    show_passenger_wagons_list(Station.all[current_station])
    station_menu(current_station)
  end

  def show_cargo_trains
    trains = Station.all[current_station].trains_by_type(Cargo)
    puts "Поездов на станции (тип #{TrainTypeDescription.dig(:cargo, :name)}): #{trains.length}"
    show_cargo_train_list(Station.all[current_station])
    station_menu(current_station)
  end

  def show_passenger_trains
    trains = Station.all[current_station].trains_by_type(Passenger)
    puts "Поездов на станции (тип #{TrainTypeDescription.dig(:passenger, :name)}): #{trains.length}"
    show_passenger_train_list(Station.all[current_station])
    station_menu(current_station)
  end

  def construct_station_names_list_text
    station_names_list = []
    Station.all.each_with_index{|station, index| station_names_list << [index + 1 , station.name]}
    station_names_list.map{|item| item[0].to_s + '. ' + item[1].to_s} * "\n"
  end

  def construct_route_names_list_text
    route_names_list = []
    Route.all.each_with_index{|route, index| 
      route_names_list << [index + 1 , route.stations.first.name + '—' + route.stations.last.name ]
    }
    route_names_list.map{|item| item[0].to_s + '. ' + item[1].to_s} * "\n"
  end

  def add_route
    if Station.instances_amount > 1
      puts "Список станций:\n#{construct_station_names_list_text}"
      print "Введите индекс станции отправления: "
      first_station = gets.strip.to_i - 1
      print "Введите индекс станции назначения: "
      last_station = gets.strip.to_i - 1
      Route.new(Station.all[first_station],Station.all[last_station])
      puts "Создан маршрут #{Station.all[first_station].name}—#{Station.all[last_station].name}"
    else
      puts "Список станций пустой. Сначала создайте станции"
    end
    main_menu
  end

  def construct_route_station_list(route_index)
    station_names_list = []
    Route.all[route_index].stations.each_with_index{|station, index| station_names_list << [index + 1 , station.name]}
    station_names_list.map{|item| item[0].to_s + '. ' + item[1].to_s} * "\n"
  end

  def add_station_to_route
    if Route.instances_amount > 0
      puts "Список маршрутов:\n#{construct_route_names_list_text}"
      print "Введите индекс маршрута: "
      route_index = gets.strip.to_i - 1
      puts "Список станций:\n#{construct_station_names_list_text}"
      print "Введите индекс станции: "
      station_index = gets.strip.to_i - 1
      Route.all[route_index].insert_station(-2, Station.all[station_index])
      puts "На маршруте добавлена станция #{Station.all[station_index].name}"
      puts "#{construct_route_station_list(route_index)}"
    else
      puts "Список маршрутов пустой. Сначала создайте маршрут"
    end
    main_menu
  end

  def delete_station_from_route
    if Route.instances_amount > 0
      puts "#{construct_route_names_list_text}"
      print "Введите индекс маршрута: "
      route_index = gets.strip.to_i - 1
      puts "#{construct_route_station_list(route_index)}"
      print "Введите индекс станции на маршрут: "
      station_index = gets.strip.to_i - 1
      Route.all[route_index].remove_station(Station.all[station_index])
      puts "На маршруте удалена станция #{Station.all[station_index].name}"
      puts "#{construct_route_station_list(route_index)}"
    else
      puts "Список маршрутов пустой. Сначала создайте маршрут"
    end
    main_menu
  end

  def take_train_type
    show_train_type_list
    print "Выберите тип поезда: "
    gets.strip.to_i
  end

  def add_train
    if !Route.instances_amount.nil? && Route.instances_amount > 0
      type_index = take_train_type

      puts "Список маршрутов:\n#{construct_route_names_list_text}"
      print "Введите индекс маршрута: "
      route_index = gets.strip.to_i - 1

      print "Введите номер поезда: "
      begin
        attempt ||= 0
        number = gets.strip
        case type_index
        when Cargo
          CargoTrain.new(number)
          cargo_train_last = CargoTrain.all[-1]
          cargo_train_last.take_route(Route.all[route_index])
          puts "Создан #{TrainTypeDescription.dig(:cargo, :name)} поезд №#{cargo_train_last.number}"
          puts "На маршруте #{cargo_train_last.route.stations.first.name + '—' + cargo_train_last.route.stations.last.name}"
        when Passenger
          PassengerTrain.new(number)
          passenger_train_last = PassengerTrain.all[-1]
          passenger_train_last.take_route(Route.all[route_index])
          puts "Создан #{TrainTypeDescription.dig(:passenger, :name)} поезд №#{passenger_train_last.number}"
          puts "На маршруте #{passenger_train_last.route.stations.first.name + '—' + passenger_train_last.route.stations.last.name}"
        end
      rescue RuntimeError => e
        puts "Error: #{e.message}"
        puts "Allowed format (XXX-XX). Allowed characters: a-z, а-я, 0-9"
        print 'Повторите ввод номера поезда: '
        retry if (attempt += 1) < 3
      end
    else
      puts "Список маршрутов пустой. Сначала создайте маршрут"
    end
    main_menu
  end

  def construct_passenger_train_list_text
    passenger_train_numbers_list = []
    PassengerTrain.all.each_with_index{|train, index| passenger_train_numbers_list << [index + 1 , train.number, TrainTypeDescription.dig(:passenger, :name), '[' + train.wagons.length.to_s + ']' , train.route_info]}
    passenger_train_numbers_list.map{|item| item[0].to_s + '. ' + item[1, 4] * " "} * "\n"
  end

  def construct_cargo_train_list_text
    cargo_train_numbers_list = []
    CargoTrain.all.each_with_index{|train, index| cargo_train_numbers_list << [index + 1 , train.number, TrainTypeDescription.dig(:cargo, :name), '[' + train.wagons.length.to_s + ']', train.route_info]}
    cargo_train_numbers_list.map{|item| item[0].to_s + '. ' + item[1, 4] * " "} * "\n"
  end

  def show_passenger_train_list(station_object)
    station_object.trains_list(Passenger) do |train, index|
      puts "#{index}. Поезд № #{train.number}; Тип: #{TrainTypeDescription.dig(:passenger, :name)}; Вагонов: #{train.wagons.length}; Маршрут: #{train.route_info}"
    end
  end

  def show_cargo_train_list(station_object)
    station_object.trains_list(Cargo) do |train, index|
      puts "#{index}. Поезд № #{train.number}; Тип: #{TrainTypeDescription.dig(:cargo, :name)}; Вагонов: #{train.wagons.length}; Маршрут: #{train.route_info}"
    end
  end

  def move_forward
    puts "Поезд переехал вперёд"
    type_index = take_train_type

    if type_index == Cargo && !CargoTrain.instances_amount.nil? && CargoTrain.instances_amount > 0 
      puts "Список поездов:\n#{construct_cargo_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      CargoTrain.all[train_index].move_to_next_station
      puts "Поезд переехал вперёд к станции #{CargoTrain.all[train_index].station.name}"
    elsif type_index == Passenger && !PassengerTrain.instances_amount.nil? && PassengerTrain.instances_amount > 0 
      puts "Список поездов:\n#{construct_passenger_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      PassengerTrain.all[train_index].move_to_next_station
      puts "Поезд переехал вперёд к станции #{PassengerTrain.all[train_index].station.name}"
    else
      puts "Список поездов пустой. Сначала создайте поезд"
    end
    main_menu
  end

  def move_backward
    type_index = take_train_type

    if type_index == Cargo && !CargoTrain.instances_amount.nil? && CargoTrain.instances_amount > 0 
      puts "Список поездов:\n#{construct_passenger_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      CargoTrain.all[train_index].move_to_previos_station
      puts "Поезд переехал назад к станции #{CargoTrain.all[train_index].station.name}"
    elsif type_index == Passenger && !PassengerTrain.instances_amount.nil? && PassengerTrain.instances_amount > 0 
      puts "Список поездов:\n#{construct_cargo_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      PassengerTrain.all[train_index].move_to_previos_station
      puts "Поезд переехал назад к станции #{PassengerTrain.all[train_index].station.name}"
    else
      puts "Список поездов пустой. Сначала создайте поезд"
    end
    main_menu
  end

  def take_station_by_train(train_object)
    Station.get_station_by_train(train_object)
  end

  def get_passenger_wagon_from_station(station_object)
    wagon_index = gets.strip.to_i    
    wagons_amount = station_object.wagons_by_type(Passenger).length
    if wagon_index < 1 || wagon_index > wagons_amount
      puts "Введите индекс вагона в интервале []"
      print "Повторите ввод числа в интервале [1 , #{wagons_amount}]: "
    else
      station_object.wagons_by_type(Passenger)[wagon_index - 1]
    end
  end

  def get_cargo_wagon_from_station(station_object)
    wagon_index = gets.strip.to_i    
    wagons_amount = station_object.wagons_by_type(Cargo).length
    if wagon_index < 1 || wagon_index > wagons_amount
      puts "Введите индекс вагона в интервале []"
      print "Повторите ввод числа в интервале [1 , #{wagons_amount}]: "
    else
      station_object.wagons_by_type(Cargo)[wagon_index - 1]
    end
  end

  def show_cargo_wagons_list(station_object)
    station_object.wagons_list(Cargo) do |wagon, index|
      puts "#{index}. #{TrainTypeDescription.dig(:cargo, :name)} вагон с объёмом #{wagon.max_volume}. Занятый объем #{wagon.occupied_volume}"
    end
  end

  def show_passenger_wagons_list(station_object)
    station_object.wagons_list(Passenger) do |wagon, index|
      puts "#{index}. #{TrainTypeDescription.dig(:passenger, :name)} вагон на #{wagon.max_seats} мест. Занято #{wagon.occupied_seats} мест"
    end
  end

  def show_train_wagons_list(train_object)
    case train_object.type
    when Cargo
      train_object.wagons_list do |wagon, index|
        puts "#{index}. #{TrainTypeDescription.dig(:cargo, :name)} вагон с объемом #{wagon.max_volume}. Занятый объем #{wagon.occupied_volume}"
      end
    when Passenger
      train_object.wagons_list do |wagon, index|
        puts "#{index}. #{TrainTypeDescription.dig(:passenger, :name)} вагон на #{wagon.max_seats} мест. Занято #{wagon.occupied_seats} мест"
      end
    end  
  end

  def add_wagon
    type_index = take_train_type

    if type_index == Cargo && !CargoTrain.instances_amount.nil? && CargoTrain.instances_amount > 0 
      puts "Список поездов:\n#{construct_cargo_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      station_object = take_station_by_train(CargoTrain.all[train_index])

      if station_object.nil?
        puts "Выбранный поезд не находится ни на одной станции."
      elsif station_object.wagons_by_type(Cargo).length > 0
        puts "Список вагонов:"
        show_cargo_wagons_list(station_object)
        print "Выберите вагон: "
        wagon = get_cargo_wagon_from_station(station_object)

        CargoTrain.all[train_index].attach_wagon(station_object.away_wagons(wagon))
        puts "Описание поезда после присоединения вагона"
        show_train_wagons_list(CargoTrain.all[train_index])
      else
        puts "На станции #{station_object.name} нет вагонов на запасных путях"
      end
    elsif type_index == Passenger && !PassengerTrain.instances_amount.nil? && PassengerTrain.instances_amount > 0 
      puts "Список поездов:\n#{construct_passenger_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1
    
      station_object = take_station_by_train(PassengerTrain.all[train_index])

      if station_object.nil?
        puts "Выбранный поезд не находится ни на одной станции."
      elsif station_object.wagons_by_type(Passenger).length > 0
        puts "Список вагонов:"
        show_passenger_wagons_list(station_object)
        print "Выберите вагон: "
        wagon = get_passenger_wagon_from_station(station_object)

        PassengerTrain.all[train_index].attach_wagon(station_object.away_wagons(wagon))
        puts "Описание поезда после присоединения вагона"
        show_train_wagons_list(PassengerTrain.all[train_index])
      else
        puts "На станции #{station_object.name} нет вагонов на запасных путях"
      end
    else
      puts "Список поездов пустой. Сначала создайте поезд"
    end
    main_menu
  end

  def detach_wagon
    type_index = take_train_type

    if type_index == Cargo && !CargoTrain.instances_amount.nil? && CargoTrain.instances_amount > 0 
      puts "Список поездов:\n#{construct_cargo_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      station_object = take_station_by_train(CargoTrain.all[train_index])
      station_object.take_wagons(CargoTrain.all[train_index].detach_wagon)
      puts "Описание поезда после отсоединения вагона"
      show_train_wagons_list(CargoTrain.all[train_index])
    elsif type_index == Passenger && !PassengerTrain.instances_amount.nil? && PassengerTrain.instances_amount > 0 
      puts "Список поездов:\n#{construct_passenger_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1
    
      station_object = take_station_by_train(PassengerTrain.all[train_index])
      station_object.take_wagons(PassengerTrain.all[train_index].detach_wagon)
      puts "Описание поезда после отсоединения вагона"
      show_train_wagons_list(PassengerTrain.all[train_index])
    else
      puts "Список поездов пустой. Сначала создайте поезд"
    end
    main_menu
  end

  def boarding_passenger
    if Station.instances_amount > 1
      puts "Список станций:\n#{construct_station_names_list_text}"
      print "Введите индекс станции отправления: "
      station_index = gets.strip.to_i - 1

      trains = Station.all[station_index].trains_by_type(Passenger)
      if trains.length > 0
        puts "Поездов на станции (тип #{TrainTypeDescription.dig(:passenger, :name)}): #{trains.length}"
        show_passenger_train_list(Station.all[station_index])
        print "Введите индекс поезда: "
        train_index = gets.strip.to_i - 1

        if trains[train_index].wagons_amount > 0
          puts "Список вагонов:"
          show_train_wagons_list(trains[train_index])
          print "Введите индекс вагона: "
          wagon_index = gets.strip.to_i - 1

          print "Посадить пассажира на поезд (нажмите Enter)"
          gets
          wagon = trains[train_index].wagons[wagon_index].take_seat

          puts "Описание вагонов поезда #{trains[train_index].number} после посадки пассажира:"
          show_train_wagons_list(trains[train_index])
        else
          puts "Поезд без вагонов"
        end
      else
        puts "Поездов на станции нет. Сначала дождитесь прибытия поезда"
      end
    else
      puts "Список станций пустой. Сначала создайте станции"
    end

    main_menu
  end

  def unboarding_passenger
    if Station.instances_amount > 1
      puts "Список станций:\n#{construct_station_names_list_text}"
      print "Введите индекс станции отправления: "
      station_index = gets.strip.to_i - 1

      trains = Station.all[station_index].trains_by_type(Passenger)
      if trains.length > 0
        puts "Поездов на станции (тип #{TrainTypeDescription.dig(:passenger, :name)}): #{trains.length}"
        show_passenger_train_list(Station.all[station_index])
        print "Введите индекс поезда: "
        train_index = gets.strip.to_i - 1

        if trains[train_index].wagons_amount > 0
          puts "Список вагонов:"
          show_train_wagons_list(trains[train_index])
          print "Введите индекс вагона: "
          wagon_index = gets.strip.to_i - 1

          print "Снять пассажира с поезда (нажмите Enter)"
          gets
          wagon = trains[train_index].wagons[wagon_index].get_out_seat

          puts "Описание вагонов поезда #{trains[train_index].number} после высадки пассажира:"
          show_train_wagons_list(trains[train_index])
        else
          puts "Поезд без вагонов"
        end
      else
        puts "Поездов на станции нет. Сначала дождитесь прибытия поезда"
      end
    else
      puts "Список станций пустой. Сначала создайте станции"
    end

    main_menu
  end

  def loading_cargo
    if Station.instances_amount > 1
      puts "Список станций:\n#{construct_station_names_list_text}"
      print "Введите индекс станции отправления: "
      station_index = gets.strip.to_i - 1

      trains = Station.all[station_index].trains_by_type(Cargo)
      if trains.length > 0
        puts "Поездов на станции (тип #{TrainTypeDescription.dig(:cargo, :name)}): #{trains.length}"
        show_cargo_train_list(Station.all[station_index])
        print "Введите индекс поезда: "
        train_index = gets.strip.to_i - 1

        if trains[train_index].wagons_amount > 0
          puts "Список вагонов:"
          show_train_wagons_list(trains[train_index])
          print "Введите индекс вагона: "
          wagon_index = gets.strip.to_i - 1

          print "Загрузить одну единицу объёма груза в вагон (нажмите Enter)"
          gets
          wagon = trains[train_index].wagons[wagon_index].take_volume

          puts "Описание вагонов поезда #{trains[train_index].number} после загрузки:"
          show_train_wagons_list(trains[train_index])
        else
          puts "Поезд без вагонов"
        end
      else
        puts "Поездов на станции нет. Сначала дождитесь прибытия поезда"
      end
    else
      puts "Список станций пустой. Сначала создайте станции"
    end

    main_menu
  end

  def unloading_cargo
    if Station.instances_amount > 1
      puts "Список станций:\n#{construct_station_names_list_text}"
      print "Введите индекс станции отправления: "
      station_index = gets.strip.to_i - 1

      trains = Station.all[station_index].trains_by_type(Cargo)
      if trains.length > 0
        puts "Поездов на станции (тип #{TrainTypeDescription.dig(:cargo, :name)}): #{trains.length}"
        show_cargo_train_list(Station.all[station_index])
        print "Введите индекс поезда: "
        train_index = gets.strip.to_i - 1

        if trains[train_index].wagons_amount > 0
          puts "Список вагонов:"
          show_train_wagons_list(trains[train_index])
          print "Введите индекс вагона: "
          wagon_index = gets.strip.to_i - 1

          print "Разгрузить одну единицу объёма груза из вагона (нажмите Enter)"
          gets
          wagon = trains[train_index].wagons[wagon_index].get_out_volume

          puts "Описание вагонов поезда #{trains[train_index].number} после разгрузки:"
          show_train_wagons_list(trains[train_index])
        else
          puts "Поезд без вагонов"
        end
      else
        puts "Поездов на станции нет. Сначала дождитесь прибытия поезда"
      end
    else
      puts "Список станций пустой. Сначала создайте станции"
    end

    main_menu
  end
end

