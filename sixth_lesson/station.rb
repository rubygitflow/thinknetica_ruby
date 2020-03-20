require_relative 'instance_counter'
require_relative 'validator'

class Station
  include InstanceCounter
  include Validator

  attr_reader :name, :trains, :passenger_wagons, :cargo_wagons

  INCLUDE_SYMBOL_EXAMPLE = /^[a-zа-я0-9\s\-]{3,}/i.freeze
  EXCLUDE_SYMBOL_EXAMPLE = /[\W][^а-я0-9\s\-]+/i.freeze

  @@stations = []

  def initialize(name)
    @name = name
    validate!

    @trains = []
    @passenger_wagons = []
    @cargo_wagons = []
    @@stations << self
    register_instance
  end

  def validate!
    raise "Name has invalid format" if name !~ INCLUDE_SYMBOL_EXAMPLE || name =~ EXCLUDE_SYMBOL_EXAMPLE  
  end

  def take_train(train)
    @trains << train unless trains.include?(train)
  end

  def send_train(train)
    @trains.delete(train) unless @trains.empty?
  end

  def take_cargo_wagons(wagon)
    @cargo_wagons << wagon unless cargo_wagons.include?(wagon)
  end

  def away_cargo_wagons
    @cargo_wagons.pop unless cargo_wagons.empty?
  end

  def take_passenger_wagons(wagon)
    @passenger_wagons << wagon unless passenger_wagons.include?(wagon)
  end

  def away_passenger_wagons
    @passenger_wagons.pop unless passenger_wagons.empty?
  end

  def trains_by_type(type)
    trains.select {|element| element.type == type}
  end

  def self.all
    @@stations
  end
end
