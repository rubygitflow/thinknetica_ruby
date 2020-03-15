require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'

class TextInterface
  # Здесь общая реализация текстового интерфейса программы
  APPLICATION_NAME = 'Управление железной дорогой'

  attr_reader  :menu_input,  :station_menu_input,  :menu_cursor,  :station_list,  :route_list,  
               :passenger_train_list, :cargo_train_list

  # Меню диалогового интерфейса программы 
  # Разрешаем изменять его в наследниках класса
  def initialize

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
        name: 'Выйти из программы',
        link: :exit
      }
    }  

    @station_menu_input = { 
      1 => {  
        name: 'Создать товарный вагон',
        link: :add_cargo_wagon
      }, 
      2 => {  
        name: 'Создать пассажирский вагон',
        link: :add_passenger_wagon
      }, 
      3 => {  
        name: 'Показать статистику по товарным вагонам на запасных путях',
        link: :show_cargo_wagons
      }, 
      4 => {  
        name: 'Показать статистику по пассажирским вагонам на запасных путях',
        link: :show_passenger_wagons
      }, 
      5 => {  
        name: 'Показать статистику по товарным поездам',
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
    @station_list = []
    @route_list = []
    @passenger_train_list = []
    @cargo_train_list = []
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
    exit_menu_index = station_list.length + 1
    
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
                       station_list[station_index].name + ":"
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
    name = gets.strip

    if station_list.detect { |station| station.name == name }
      puts "Станция #{name.inspect} уже существует."
    else 
      @station_list << Station.new(name)
      puts "Станция #{name.inspect} добавлена"
      @station_list = @station_list.sort_by {|x| [x.name]}
    end
    main_menu
  end

  def construct_station_list
    if station_list.empty?
      puts "Список станций пустой"
      false
    else
      station_names_list = []
      station_list.each_with_index{|station, index| station_names_list << [index+1 , station.name]}
      station_names_list_text = station_names_list.map{|item| item[0].to_s + '. ' + item[1].to_s}
      puts station_names_list_text * "\n" + "\n" + (station_list.length + 1).to_s + ". Вернуться к меню 'Станция'"
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

  def add_cargo_wagon
    @station_list[current_station].take_cargo_wagons(CargoWagon.new)
    puts "На запасные пути поставлен новый товарный вагон."
    puts "Товарных вагонов на станции: #{station_list[current_station].cargo_wagons.length}"
    station_menu(current_station)
  end

  def add_passenger_wagon
    @station_list[current_station].take_passenger_wagons(PassengerWagon.new)
    puts "На запасные пути поставлен новый пассажирский вагон."
    puts "Пассажирских вагонов на станции: #{station_list[current_station].passenger_wagons.length}"
    station_menu(current_station)
  end

  def show_cargo_wagons
    puts "Товарных вагонов на станции: #{station_list[current_station].cargo_wagons.length}"
    station_menu(current_station)
  end

  def show_passenger_wagons
    puts "Пассажирских вагонов на станции: #{station_list[current_station].passenger_wagons.length}"
    station_menu(current_station)
  end

  def show_cargo_trains
    trains = station_list[current_station].trains_by_type(:cargo)
    puts "Товарных поездов на станции: #{trains.length}"
    puts "#{trains}"
    station_menu(current_station)
  end

  def show_passenger_trains
    trains = station_list[current_station].trains_by_type(:passenger)
    puts "Пассажирских поездов на станции: #{trains.length}"
    puts "#{trains}"
    station_menu(current_station)
  end

  def construct_station_names_list_text
    station_names_list = []
    station_list.each_with_index{|station, index| station_names_list << [index + 1 , station.name]}
    station_names_list.map{|item| item[0].to_s + '. ' + item[1].to_s} * "\n"
  end

  def construct_route_names_list_text
    route_names_list = []
    route_list.each_with_index{|route, index| 
      route_names_list << [index + 1 , route.stations.first.name + '—' + route.stations.last.name ]
    }
    route_names_list.map{|item| item[0].to_s + '. ' + item[1].to_s} * "\n"
  end

  def add_route
    if station_list.length > 1
      puts "Список станций:\n#{construct_station_names_list_text}"
      print "Введите индекс станции отправления: "
      first_station = gets.strip.to_i - 1
      print "Введите индекс станции назначения: "
      last_station = gets.strip.to_i - 1
      @route_list << Route.new(station_list[first_station],station_list[last_station])
      puts "Создан маршрут #{station_list[first_station].name}—#{station_list[last_station].name}"
      # puts "#{@route_list.inspect}"
    else
      puts "Список станций пустой. Сначала создайте станции"
    end
    main_menu
  end

  def construct_route_station_list(route_index)
    station_names_list = []
    route_list[route_index].stations.each_with_index{|station, index| station_names_list << [index + 1 , station.name]}
    station_names_list.map{|item| item[0].to_s + '. ' + item[1].to_s} * "\n"
  end

  def add_station_to_route
    if @route_list.length > 0
      puts "Список маршрутов:\n#{construct_route_names_list_text}"
      print "Введите индекс маршрута: "
      route_index = gets.strip.to_i - 1
      puts "Список станций:\n#{construct_station_names_list_text}"
      print "Введите индекс станции: "
      station_index = gets.strip.to_i - 1
      @route_list[route_index].insert_station(-2, station_list[station_index])
      puts "На маршруте добавлена станция #{station_list[station_index].name}"
      puts "#{construct_route_station_list(route_index)}"
    else
      puts "Список маршрутов пустой. Сначала создайте маршрут"
    end
    main_menu
  end

  def delete_station_from_route
    if route_list.length > 0
      puts "#{construct_route_names_list_text}"
      print "Введите индекс маршрута: "
      route_index = gets.strip.to_i - 1
      puts "#{construct_route_station_list(route_index)}"
      print "Введите индекс станции: "
      station_index = gets.strip.to_i - 1
      route_list[route_index].remove_station(station_list[station_index])
      puts "На маршруте удалена станция #{station_list[station_index].name}"
      puts "#{construct_route_station_list(route_index)}"
    else
      puts "Список маршрутов пустой. Сначала создайте маршрут"
    end
    main_menu
  end

  def take_train_type
      puts "1. Cargo"
      puts "2. Passenger"
      print "Выберите тип поезда: "
      gets.strip.to_i
  end

  def add_train
    if route_list.length > 0
      type_index = take_train_type

      print "Введите номер поезда: "
      number = gets.strip

      puts "Список маршрутов:\n#{construct_route_names_list_text}"
      print "Введите индекс маршрута: "
      route_index = gets.strip.to_i - 1

      case type_index
      when 1
        @cargo_train_list << CargoTrain.new(number)
        @cargo_train_list[-1].take_route(route_list[route_index])
        puts "Создан грузовой поезд №#{@cargo_train_list[-1].number}"
        puts "На маршруте #{@cargo_train_list[-1].route.stations.first.name + '—' + @cargo_train_list[-1].route.stations.last.name}"
      else
        @passenger_train_list << PassengerTrain.new(number)
        @passenger_train_list[-1].take_route(route_list[route_index])
        puts "Создан пассажирский поезд №#{@passenger_train_list[-1].number}"
        puts "На маршруте #{@passenger_train_list[-1].route.stations.first.name + '—' + @passenger_train_list[-1].route.stations.last.name}"
      end
    else
      puts "Список маршрутов пустой. Сначала создайте маршрут"
    end
    main_menu
  end

  def construct_passenger_train_list_text
    passenger_train_numbers_list = []
    passenger_train_list.each_with_index{|train, index| passenger_train_numbers_list << [index + 1 , train.number]}
    passenger_train_numbers_list.map{|item| item[0].to_s + '. ' + item[1].to_s} * "\n"
  end

  def construct_cargo_train_list_text
    cargo_train_numbers_list = []
    cargo_train_list.each_with_index{|train, index| cargo_train_numbers_list << [index + 1 , train.number]}
    cargo_train_numbers_list.map{|item| item[0].to_s + '. ' + item[1].to_s} * "\n"
  end

  def move_forward
    puts "Поезд переехал вперёд"
    type_index = take_train_type

    if type_index == 1 && cargo_train_list.length > 0 
      puts "Список поездов:\n#{construct_passenger_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      passenger_train_list[train_index].move_to_next_station
      puts "Поезд переехал вперёд к станции #{passenger_train_list[train_index].station.name}"

    elsif station_index == 2 && passenger_train_list.length > 0 
      puts "Список поездов:\n#{construct_cargo_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      cargo_train_list[train_index].move_to_next_station
      puts "Поезд переехал вперёд к станции #{cargo_train_list[train_index].station.name}"
    else
      puts "Список поездов пустой. Сначала создайте поезд"
    end
    main_menu
  end

  def move_backward
    type_index = take_train_type

    if type_index == 1 && cargo_train_list.length > 0 
      puts "Список поездов:\n#{construct_passenger_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      passenger_train_list[train_index].move_to_previos_station
      puts "Поезд переехал назад к станции #{passenger_train_list[train_index].station.name}"

    elsif station_index == 2 && passenger_train_list.length > 0 
      puts "Список поездов:\n#{construct_cargo_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      cargo_train_list[train_index].move_to_previos_station
      puts "Поезд переехал назад к станции #{cargo_train_list[train_index].station.name}"
    else
      puts "Список поездов пустой. Сначала создайте поезд"
    end
    main_menu
  end

  def add_wagon
    type_index = take_train_type

    if type_index == 1 && cargo_train_list.length > 0 
      puts "Список поездов:\n#{construct_passenger_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1
    
      print "Введите индекс станции: "
      station_index = gets.strip.to_i - 1

      passenger_train_list[train_index].attach_wagon(station_list[station_index].away_passenger_wagons)

    elsif station_index == 2 && passenger_train_list.length > 0 
      puts "Список поездов:\n#{construct_cargo_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      print "Введите индекс станции: "
      station_index = gets.strip.to_i - 1

      cargo_train_list[train_index].attach_wagon(station_list[station_index].away_cargo_wagons)
    else
      puts "Список поездов пустой. Сначала создайте поезд"
    end
    main_menu
  end

  def detach_wagon
    type_index = take_train_type

    if type_index == 1 && cargo_train_list.length > 0 
      puts "Список поездов:\n#{construct_passenger_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1
    
      print "Введите индекс станции: "
      station_index = gets.strip.to_i - 1

      passenger_train_list[train_index].attach_wagon(station_list[station_index].away_cargo_wagons)
      station_list[station_index].take_passenger_wagons(passenger_train_list[train_index].detach_wagon)

    elsif station_index == 2 && passenger_train_list.length > 0 
      puts "Список поездов:\n#{construct_cargo_train_list_text}"
      print "Введите индекс поезда: "
      train_index = gets.strip.to_i - 1

      print "Введите индекс станции: "
      station_index = gets.strip.to_i - 1

      station_list[station_index].take_cargo_wagons(cargo_train_list[train_index].detach_wagon)
    else
      puts "Список поездов пустой. Сначала создайте поезд"
    end
    main_menu
  end
end
