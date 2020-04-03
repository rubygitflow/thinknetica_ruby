# frozen_string_literal: true

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
    wagon1 = PassengerWagon.new 20
    wagon2 = PassengerWagon.new 25

    wagon3 = CargoWagon.new 10
    wagon4 = CargoWagon.new 15

    station1 = Station.new 'Полынка'
    station2 = Station.new 'Тамбовка'

    station3 = Station.new 'Зарядье'
    station4 = Station.new 'Болотная'

    station1.take_wagons(wagon1)
    station1.take_wagons(wagon2)

    station3.take_wagons(wagon3)
    station3.take_wagons(wagon4)

    route1 = Route.new station1, station2

    route2 = Route.new station3, station4

    number1p = '100-FD'
    PassengerTrain.new number1p

    passenger_train_last_p = PassengerTrain.all[-1]
    passenger_train_last_p.take_route(route1)

    passenger_train_last_p.attach_wagon(station1.away_wagons(wagon1))
    

    number2c = '3UU-10'
    CargoTrain.new number2c

    passenger_train_last_c = CargoTrain.all[-1]
    passenger_train_last_c.take_route(route2)

    
    passenger_train_last_c.attach_wagon(station3.away_wagons(wagon3))
  end
end
