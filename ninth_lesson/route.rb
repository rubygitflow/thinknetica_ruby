# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :first_station, :last_station

  validate :first_station, :presence
  validate :last_station, :presence

  @@routes = []

  class << self
    def all
      @@routes
    end
  end

  def initialize(first, last)
    @first_station = first
    @last_station = last
    validate!

    @stations = [first, last]
    @@routes << self
    register_instance
  end

  def first_station
    stations.first
  end

  def previous_station(station)
    i = stations.index(station)
    stations[i - 1] if i.positive?
  end

  def next_station(station)
    i = stations.index(station)
    stations[i + 1] if station != stations.last
  end

  def insert_station(index, station)
    @stations.insert(index, station) if index >= -stations.count &&
                                        index < stations.count
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def map_stations
    stations.map(&:name)
  end
end
