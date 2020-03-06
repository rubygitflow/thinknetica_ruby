require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'

def draw_stations_state(item, list)
  def get_trains_by_type(station, type)
    station.trains_by_type(type).map{ |train| train.number }.inspect
  end

  puts "\n"
  puts "Список поездов на станциях.#{item.inspect}"
  list.each{ |station|
    type_passenger = :passenger
    type_cargo = :cargo

    puts "'#{station.name}' > #{type_cargo}: #{get_trains_by_type(station, type_cargo)}; #{type_passenger}: #{get_trains_by_type(station, type_passenger)}"
  }
  puts "\n"
end

# station_0 = Station.new('Москва')
# station_1 = Station.new('Смоленская')
# station_2 = Station.new('Петрозаводская')
# station_3 = Station.new('Киевская')
# station_4 = Station.new('Белорусская')
# station_5 = Station.new('Свердловская')
# station_6 = Station.new('Питерская')
# station_7 = Station.new('Казанская')

# puts "Список маршрутов"
# route_0 = Route.new(station_0,station_6)
# route_0.insert_station(1,station_2)
# route_0.insert_station(2,station_1)
# puts "route_0.map_stations=#{route_0.map_stations}"

# route_1 = Route.new(station_0,station_3)
# puts "route_1.map_stations=#{route_1.map_stations}"

# route_2 = Route.new(station_0,station_4)
# route_2.insert_station(1,station_5)
# route_2.insert_station(2,station_6)
# route_2.insert_station(3,station_7)
# route_2.remove_station(station_6)
# puts "route_2.map_stations=#{route_2.map_stations}"

# draw_stations_state(1,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# wagon_1 = CargoWagon.new
# wagon_2 = CargoWagon.new
# wagon_3 = CargoWagon.new
# wagon_4 = CargoWagon.new
# wagon_5 = CargoWagon.new

# wagon_11 = CargoWagon.new
# wagon_12 = CargoWagon.new
# wagon_13 = CargoWagon.new
# wagon_14 = CargoWagon.new
# wagon_15 = CargoWagon.new


# puts "Длины составов"
# cargotrain_0 = CargoTrain.new('1')
# cargotrain_0.attach_wagon(wagon_1)
# cargotrain_0.attach_wagon(wagon_2)
# cargotrain_0.attach_wagon(wagon_3)
# cargotrain_0.attach_wagon(wagon_4)
# cargotrain_0.attach_wagon(wagon_5)
# cargotrain_0.take_route(route_0)
# puts "cargotrain_0.length=#{cargotrain_0.wagon_count}"

# cargotrain_1 = CargoTrain.new('2')
# cargotrain_1.attach_wagon(wagon_11)
# cargotrain_1.attach_wagon(wagon_12)
# cargotrain_1.attach_wagon(wagon_1)
# cargotrain_1.take_route(route_1)
# puts "cargotrain_1.length=#{cargotrain_1.wagon_count}"

# cargotrain_2 = CargoTrain.new('3')
# # cargotrain_2.attach_wagon(wagon_12) # пока без проверки дублей
# cargotrain_2.attach_wagon(wagon_13)
# cargotrain_2.attach_wagon(wagon_14)
# cargotrain_2.attach_wagon(wagon_15)
# cargotrain_2.detach_wagon
# # cargotrain_2.attach_wagon(wagon_2)  # пока без проверки дублей
# cargotrain_2.take_route(route_0)
# puts "cargotrain_2.length=#{cargotrain_2.wagon_count}"

# wagon_21 = PassengerWagon.new
# wagon_22 = PassengerWagon.new
# wagon_23 = PassengerWagon.new
# wagon_24 = PassengerWagon.new
# wagon_25 = PassengerWagon.new

# wagon_31 = PassengerWagon.new
# wagon_32 = PassengerWagon.new
# wagon_33 = PassengerWagon.new
# wagon_34 = PassengerWagon.new
# wagon_35 = PassengerWagon.new

# passengertrain_0 = PassengerTrain.new('1')
# passengertrain_0.attach_wagon(wagon_21)
# passengertrain_0.attach_wagon(wagon_22)
# passengertrain_0.attach_wagon(wagon_23)
# passengertrain_0.take_route(route_0)
# puts "passengertrain_0.length=#{passengertrain_0.wagon_count}"

# passengertrain_1 = PassengerTrain.new('2')
# passengertrain_1.attach_wagon(wagon_24)
# passengertrain_1.attach_wagon(wagon_25)
# passengertrain_1.take_route(route_1)
# puts "passengertrain_1.length=#{passengertrain_1.wagon_count}"

# passengertrain_2 = PassengerTrain.new('3')
# passengertrain_2.attach_wagon(wagon_31)
# passengertrain_2.attach_wagon(wagon_32)
# passengertrain_2.attach_wagon(wagon_12)
# passengertrain_2.attach_wagon(wagon_34)
# passengertrain_2.attach_wagon(wagon_35)
# passengertrain_2.take_route(route_2)
# puts "passengertrain_2.length=#{passengertrain_2.wagon_count}"

# puts "\nПОЕХАЛИ!\n"

# draw_stations_state(2,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# cargotrain_0.gain_speed(10)
# cargotrain_1.gain_speed(10)
# cargotrain_2.gain_speed(10)

# draw_stations_state(3,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.gain_speed(20)
# passengertrain_1.gain_speed(20)
# passengertrain_2.gain_speed(20)

# draw_stations_state(4,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# cargotrain_0.move_to_next_station
# cargotrain_1.move_to_next_station
# cargotrain_2.move_to_next_station

# draw_stations_state(5,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_next_station
# passengertrain_1.move_to_next_station
# passengertrain_2.move_to_next_station

# draw_stations_state(6,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_next_station
# passengertrain_1.move_to_next_station
# cargotrain_0.move_to_next_station

# draw_stations_state(7,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_next_station
# passengertrain_2.move_to_next_station

# draw_stations_state(8,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_next_station
# cargotrain_1.move_to_next_station
# cargotrain_2.move_to_next_station

# draw_stations_state(9,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# cargotrain_0.move_to_next_station
# cargotrain_1.move_to_next_station
# cargotrain_2.move_to_next_station

# draw_stations_state(10,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_previos_station
# passengertrain_1.move_to_next_station
# passengertrain_2.move_to_next_station

# draw_stations_state(11,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_previos_station
# passengertrain_1.move_to_next_station
# passengertrain_2.move_to_previos_station

# cargotrain_0.move_to_next_station
# cargotrain_1.move_to_previos_station
# cargotrain_2.move_to_next_station

# draw_stations_state(12,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_next_station
# passengertrain_1.move_to_previos_station
# passengertrain_2.move_to_next_station

# cargotrain_0.move_to_previos_station
# cargotrain_1.move_to_next_station
# cargotrain_2.move_to_previos_station

# draw_stations_state(13,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_next_station
# passengertrain_1.move_to_next_station
# passengertrain_2.move_to_next_station

# cargotrain_0.move_to_previos_station
# cargotrain_1.move_to_previos_station
# cargotrain_2.move_to_previos_station

# draw_stations_state(14,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_next_station
# passengertrain_1.move_to_next_station
# passengertrain_2.move_to_next_station

# cargotrain_0.move_to_previos_station
# cargotrain_1.move_to_previos_station
# cargotrain_2.move_to_previos_station

# draw_stations_state(15, [station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# passengertrain_0.move_to_next_station
# passengertrain_1.move_to_next_station
# passengertrain_2.move_to_next_station

# cargotrain_0.move_to_previos_station
# cargotrain_1.move_to_previos_station
# cargotrain_2.move_to_previos_station

# draw_stations_state(16,[station_0, station_1, station_2, station_3, station_4, station_5, station_6, station_7])

# cargotrain_0.gain_speed(0)
# cargotrain_1.gain_speed(0)
# cargotrain_2.gain_speed(0)

# passengertrain_0.gain_speed(0)
# passengertrain_1.gain_speed(0)
# passengertrain_2.gain_speed(0)

# puts "\nОСТАНОВИЛИСЬ!\n"

# puts "Проверка станций у составов"
# puts "cargotrain_0 #{cargotrain_0.number} '#{cargotrain_0.station.name}' > #{cargotrain_0.route.map_stations}"
# puts "cargotrain_1 #{cargotrain_1.number} '#{cargotrain_1.station.name}' > #{cargotrain_1.route.map_stations}"
# puts "cargotrain_2 #{cargotrain_2.number} '#{cargotrain_2.station.name}' > #{cargotrain_2.route.map_stations}"

# puts "passengertrain_0 #{put.number} '#{passengertrain_0.station.name}' > #{passengertrain_0.route.map_stations}"
# puts "passengertrain_1 #{passengertrain_1.number} '#{passengertrain_1.station.name}' > #{passengertrain_1.route.map_stations}"
# puts "passengertrain_2 #{passengertrain_2.number} '#{passengertrain_2.station.name}' > #{passengertrain_2.route.map_stations}"

  # puts "Вернуться на шаг назад"  

def repeat_input_from__section_menu(navigate_to, repeated_function)
  puts "
    Выбрано #{navigate_to}
    Это недопустимое значение
    Повторите ввод числа из меню раздела программы."

  repeated_function
end
  
def case_add_station
  navigate_to = gets.to_i

  case navigate_to
  when 1
    puts "1.1. Создать станцию"
    add_station
  when 2
    main_menu
  else
    repeat_input_from__section_menu(navigate_to, case_add_station)
    add_station
  end
end

def add_station
  puts "
  Меню раздела '1. Создать станцию'.
  1. Создать станцию
  2. Вернуться в главное меню
  "
  puts "Введите номер пункта из меню раздела и нажмите Enter: "

  case_add_station
end

def case_add_train
  navigate_to = gets.to_i

  case navigate_to
  when 1
    puts "2.1. Создать маршрут"
    add_train
  when 2
    main_menu
  else
    repeat_input_from__section_menu(navigate_to, case_add_train)
    add_train
  end
end

def add_train
  puts "
  Меню раздела '2. Создать поезд'.
  1. Создать поезд
  2. Вернуться в главное меню
  "
  puts "Введите номер пункта из меню раздела и нажмите Enter: "

  case_add_train
end

def case_add_route
  navigate_to = gets.to_i

  case navigate_to
  when 1
    puts "3.1. Создать маршрут"
    add_route
  when 2
    puts "3.2. Выбрать поезд"
    add_route
  when 3
    main_menu
  else
    repeat_input_from__section_menu(navigate_to, case_add_route)
    add_route
  end
end

def add_route
  puts "
  Меню раздела '3. Создать маршруты и управлять станциями в нем (добавлять, удалять)'.
  1. Создать маршрут
  2. Выбрать маршрут
  3. Вернуться в главное меню
  "
  puts "Введите номер пункта из меню раздела и нажмите Enter: "

  case_add_route
end

def case_connect_route_to_train
  navigate_to = gets.to_i

  case navigate_to
  when 1
    puts "4.1. Выбрать поезд"
    connect_route_to_train
  when 2
    main_menu
  else
    repeat_input_from__section_menu(navigate_to, case_connect_route_to_train)
    connect_route_to_train
  end
end

def connect_route_to_train
  puts "
  Меню раздела '4. Назначить маршрут поезду'.
  1. Выбрать поезд
  2. Вернуться в главное меню
  "
  puts "Введите номер пункта из меню раздела и нажмите Enter: "

  case_connect_route_to_train
end

def case_connect_wagon_to_train
  navigate_to = gets.to_i

  case navigate_to
  when 1
    puts "5.1. Выбрать поезд"
    connect_wagon_to_train
  when 2
    main_menu
  else
    repeat_input_from__section_menu(navigate_to, case_connect_wagon_to_train)
    connect_wagon_to_train
  end
end

def connect_wagon_to_train
  puts "
  Меню раздела '5. Добавить вагоны к поезду'.
  1. Выбрать поезд
  2. Вернуться в главное меню
  "
  puts "Введите номер пункта из меню раздела и нажмите Enter: "

  case_connect_wagon_to_train
end

def case_disconnect_wagon_from_train
  navigate_to = gets.to_i

  case navigate_to
  when 1
    puts "6.1. Выбрать поезд"
    disconnect_wagon_from_train
  when 2
    main_menu
  else
    repeat_input_from__section_menu(navigate_to, case_disconnect_wagon_from_train)
    disconnect_wagon_from_train
  end
end

def disconnect_wagon_from_train
  puts "
  Меню раздела '6. Отцепить вагоны от поезда'.
  1. Выбрать поезд
  2. Вернуться в главное меню
  "
  puts "Введите номер пункта из меню раздела и нажмите Enter: "

  case_disconnect_wagon_from_train
end

def case_move_train
  navigate_to = gets.to_i

  case navigate_to
  when 1
    puts "7.1. Задать скорость поезду"
    move_train
  when 2
    puts "7.2. Переместить поезд к следующей по маршруту станции"
    move_train
  when 3
    puts "7.3. Переместить поезд к предыдущей по маршруту станции"
    move_train
  when 4
    puts "7.4. Остановить поезд"
    move_train
  when 5
    main_menu
  else
    repeat_input_from__section_menu(navigate_to, case_move_train)
    move_train
  end
end

def move_train
  puts "
  Меню раздела '7. Переместить поезд по маршруту вперед и назад'.
  1. Задать скорость поезду
  2. Переместить поезд к следующей по маршруту станции
  3. Переместить поезд к предыдущей по маршруту станции
  4. Остановить поезд
  5. Вернуться в главное меню
  "
  puts "Введите номер пункта из меню раздела и нажмите Enter: "

  case_move_train
end

def case_look_station_list_and_train_list
  navigate_to = gets.to_i

  case navigate_to
  when 1
    puts "8.1. Воспроизвести список станций"
    look_station_list_and_train_list
  when 2
    puts "8.2. Воспроизвести список поездов на станции"
    look_station_list_and_train_list
  when 3
    main_menu
  else
    repeat_input_from__section_menu(navigate_to, case_look_station_list_and_train_list)
    look_station_list_and_train_list
  end
end

def look_station_list_and_train_list
  puts "
  Меню раздела '8. Просмотреть список станций и список поездов на станции'.
  1. Воспроизвести список станций
  2. Воспроизвести список поездов на станции
  3. Вернуться в главное меню
  "
  puts "Введите номер пункта из меню раздела и нажмите Enter: "

  case_look_station_list_and_train_list
end

def repeat_input_from_main_menu(navigate_to)
  puts "
    Выбрано #{navigate_to}
    Это недопустимое значение
    Повторите ввод числа из Главного меню программы."

  case_main_menu
end

def case_main_menu
  navigate_to = gets.to_i

  case navigate_to
  when 1
    add_station
  when 2
    add_train
  when 3
    add_route
  when 4
    connect_route_to_train
  when 5
    connect_wagon_to_train
  when 6
    disconnect_wagon_from_train
  when 7
    move_train
  when 8
    look_station_list_and_train_list
  when 9
    exit
  else
    repeat_input_from_main_menu(navigate_to)
  end
end

def main_menu
  puts "
  Главное меню программы.
  1. Создать станцию
  2. Создать поезд
  3. Создать маршруты и управлять станциями в нем (добавлять, удалять)
  4. Назначить маршрут поезду
  5. Добавить вагоны к поезду
  6. Отцепить вагоны от поезда
  7. Переместить поезд по маршруту вперед и назад
  8. Просмотреть список станций и список поездов на станции
  9. Выйти из программы
  "
  puts "Введите номер пункта из меню программы и нажмите Enter: "

  case_main_menu
end

main_menu
