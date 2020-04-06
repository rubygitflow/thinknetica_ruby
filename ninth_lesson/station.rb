# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains, :wagons

  INCLUDE_SYMBOL_EXAMPLE = /^[a-zа-я0-9\s\-]{3,}/i.freeze
  EXCLUDE_SYMBOL_EXAMPLE = /[\W][^а-я0-9\s\-]+/i.freeze
  
  validate :name, :presence
  validate :name, :kind, String
  validate :name, :exformat, INCLUDE_SYMBOL_EXAMPLE, EXCLUDE_SYMBOL_EXAMPLE

  @@stations = []

  class << self
    def all
      @@stations
    end

    def sort
      @@stations.sort_by { |x| [x.name] }
    end

    def get_station_by_train(train)
      station_object = nil
      train_type = train.type
      @@stations.each_with_index do |station, _index|
        unless station.trains_by_type(train_type).index(train).nil?
          station_object = station
          break
        end
      end
      station_object
    end
  end

  def initialize(name)
    @name = name
    validate!

    @trains = []
    @wagons = []
    @@stations << self
    register_instance
  end

  def take_train(train)
    @trains << train unless trains.include?(train)
  end

  def send_train(train)
    @trains.delete(train) unless @trains.empty?
  end

  def take_wagons(wagon)
    @wagons << wagon unless wagons.include?(wagon)
  end

  def away_wagons(wagon)
    @wagons.delete(wagon) if @wagons.include?(wagon)
  end

  def wagons_by_type(type)
    wagons.select { |element| element.type == type }
  end

  def trains_by_type(type)
    trains.select { |element| element.type == type }
  end

  def wagons_list(type)
    wagons_by_type(type).each_with_index do |wagon, index|
      yield(wagon, index + 1)
    end
  end

  def trains_list(type)
    trains_by_type(type).each_with_index do |train, index|
      yield(train, index + 1)
    end
  end

end
