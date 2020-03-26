require_relative 'library'
require_relative 'validator'
require_relative 'instance_counter'

require_relative 'station'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'

module Seeds

  def init_data
    wagon_1 = PassengerWagon.new 20
    wagon_2 = PassengerWagon.new 25

    wagon_3 = CargoWagon.new 10
    wagon_4 = CargoWagon.new 15

    station_1 = Station.new "Полынка"
    station_2 = Station.new "Тамбовка"

    station_3 = Station.new "Зарядье"
    station_4 = Station.new "Болотная"

    station_1.take_wagons(wagon_1)
    station_1.take_wagons(wagon_2)

    station_3.take_wagons(wagon_3)
    station_3.take_wagons(wagon_4)

    route_1 = Route.new station_1, station_2

    route_2 = Route.new station_3, station_4
    
    number_1p = "100-FD"
    train_1 = PassengerTrain.new number_1p
    passenger_train_last_p = PassengerTrain.all[-1]
    passenger_train_last_p.take_route(route_1)

    passenger_train_last_p.attach_wagon(wagon_1)
    
    number_2c = "3UU-10"
    train_2 = CargoTrain.new number_2c
    passenger_train_last_с = CargoTrain.all[-1]
    passenger_train_last_с.take_route(route_2)

    passenger_train_last_с.attach_wagon(wagon_3)
  end
end
