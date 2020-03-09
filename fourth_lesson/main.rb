require_relative 'text_interface'

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

require_relative 'text_interface'

start_program = TextInterface.new

puts "Started..."
start_program.main_menu
puts "...Finished"
