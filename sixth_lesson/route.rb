require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    register_instance
  end

  def first_station
    stations.first
  end

  def previous_station(station)
    i = stations.index(station)
    stations[i-1] if i > 0
  end

  def next_station(station)
    i = stations.index(station)
    stations[i+1] if station != stations.last
  end

  def insert_station(index, station)
    if index >= -stations.count && index < stations.count
      @stations.insert(index, station)
    end
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def map_stations
    stations.map { |station| station.name }
  end
end
