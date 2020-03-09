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
    # if !stations.include?(station) && index >= -stations.count && index < stations.count
    # повторяющиеся станции разрешаем
    if index >= -stations.count && index < stations.count
      @stations.insert(index, station)
    end
  end

  def remove_station(station)
    # слишком жесткое условие требует отладки
    # if stations.include?(station) && stations.first != station && stations.last != station
    #   @stations.delete(station) if station.trains.detect { |train| train.route == self }
    # end
    @stations.delete(station)
  end

  def map_stations
    stations.map { |station| station.name }
  end
end
