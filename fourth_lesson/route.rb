class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
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
    if !stations.include?(station) && index > 0 && index <= (stations.count - 1)
      @stations.insert(index, station)
    end
  end

  def remove_station(station)
    if stations.include?(station) && stations.first != station && stations.last != station
      @stations.delete(station) if station.trains.detect { |train| train.route == self }
    end
  end

  def map_stations
    stations.map { |station| station.name }
  end
end
