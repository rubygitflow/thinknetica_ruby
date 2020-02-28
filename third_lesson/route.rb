class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = []
    @stations << first << last
  end

  def first_station(train)
    stations.first@.take_train(train)
  end

  def previous_station(station)
    i = stations.index(station)
    if i > 0
      stations[i-1] 
    else
      false
    end
  end

  def next_station(station)
    i = stations.index(station)
    if station != stations.last
      stations[i+1] 
    else
      false
    end
  end

  def insert_station(index, station)
    if !stations.include?(station) && index > 0 && index < (stations.count - 1)
      stations.insert(index, station)
    end
  end

  def remove_station(station)
    if stations.include?(station) && stations.first != station && stations.last != station
      dependencies = 0
      station.trains.each{ |train|
        dependencies += 1 if train.route == self        
      }
      stations.delete(station) if dependencies == 0    
    end
  end

  def map_stations
    stations.map { |station| station.name }
  end
end
