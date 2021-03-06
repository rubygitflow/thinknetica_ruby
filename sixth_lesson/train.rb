require_relative 'wagon'
require_relative 'manufacturing_company'
require_relative 'validator'

class Train
  include ManufacturingCompany
  include Validator

  attr_reader :number, :type, :wagon_list, :speed, :route, :station

  NUMBER_EXAMPLE = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}/i.freeze

  @@trains = []

  def initialize(number, type)
    @number = number
    validate!

    @speed = 0
    @type = type
    @wagon_list = []
  end

  def gain_speed(speed)
    @speed = speed
  end

  def reset_speed
    @speed = 0
  end

  def attach_wagon(wagon)
    if speed == 0 && wagon.wagon_type == type
      @wagon_list << wagon
    end
  end

  def detach_wagon
    @wagon_list.pop if speed == 0 and wagon_count > 0
  end

  def take_route(route)
    @route = route
    @station = route.first_station
  end

  def previous_station
    if route.map_stations.any?
      route.previous_station(@station) 
    end
  end

  def next_station
    if route.map_stations.any?
      route.next_station(@station) 
    end
  end

  def move_to_next_station
    is_next_station = next_station
    if is_next_station
      @station.send_train(self)
      @station = is_next_station
      @station.take_train(self)
    end
  end

  def move_to_previos_station
    is_previous_station = previous_station
    if is_previous_station
      @station.send_train(self)
      @station = is_previous_station
      @station.take_train(self)
    end
  end

  def wagon_count
    wagon_list.size
  end

  def self.find(number)
    found_trains = @@trains.select {|train| train.number == number}
    found_trains.first unless found_trains.nil?
  end

  private

  def validate!
    validate_number!
  end

  def validate_number!
    raise "Number has invalid format" if number !~ NUMBER_EXAMPLE
  end

end
