# frozen_string_literal: true

require_relative 'manufacturing_company'

class Train
  include ManufacturingCompany
  include Validator

  attr_reader :number, :type, :wagons, :speed, :route, :station

  NUMBER_EXAMPLE = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}/i.freeze

  @@trains = []

  class << self
    def find(number)
      found_trains = @@trains.select { |train| train.number == number }
      found_trains&.first
    end

    private

    def all
      @@trains
    end
  end

  def initialize(number, train_type)
    @number = number
    validate!

    @speed = 0
    @type = train_type
    @wagons = []
    @@trains << self
  end

  def gain_speed(speed)
    @speed = speed
  end

  def reset_speed
    @speed = 0
  end

  def attach_wagon(wagon)
    @wagons << wagon if speed.zero? && wagon.type == type
  end

  def detach_wagon
    @wagons.pop if speed.zero? && wagons_amount.positive?
  end

  def take_route(route)
    @route = route
    @station = route.first_station
    @station.take_train(self)
  end

  def route_info
    if route.nil?
      ''
    else
      "#{route.stations.first.name} — #{route.stations.last.name}"
    end
  end

  def previous_station
    route.previous_station(@station) if route.map_stations.any?
  end

  def next_station
    route.next_station(@station) if route.map_stations.any?
  end

  def move_to_next_station
    is_next_station = next_station
    return unless is_next_station

    @station.send_train(self)
    @station = is_next_station
    @station.take_train(self)
  end

  def move_to_previos_station
    is_previous_station = previous_station
    return unless is_previous_station

    @station.send_train(self)
    @station = is_previous_station
    @station.take_train(self)
  end

  def wagons_amount
    wagons.size
  end

  def wagons_list
    wagons.each_with_index { |wagon, index| yield(wagon, index + 1) }
  end

  private

  def validate!
    validate_number!
  end

  def validate_number!
    raise 'Number has invalid format' if number !~ NUMBER_EXAMPLE
  end
end
