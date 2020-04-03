# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  @@routes = []

  class << self
    def all
      @@routes
    end
  end

  def initialize(first, last)
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
