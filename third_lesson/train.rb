class Train
  attr_reader :speed, :route, :station
  attr_reader :number, :type, :wagon_count

  def initialize(number, type, wagon_count)
    @speed = 0
    @number = number
    @type = type
    @wagon_count = wagon_count
  end

  def gain_speed(speed)
    self.speed = speed
  end

  def reset_speed
    self.speed = 0
  end

  def attach_wagon
    wagon_count += 1 if speed == 0
  end

  def detach_wagon
    wagon_count -= 1 if speed == 0 and wagon_count > 0
  end

  def take_route(route)
    @route = route
    @station = route.first_station(self)
  end

  def previous_station
    if route.any?
      route.previous_station(station) 
    else
      false
    end
  end

  def next_station
    if route.any?
      route.next_station(station) 
    else
      false
    end
  end

  def move_to_next_station
    is_next_station = next_station
    if is_next_station
      station.send_train(self)
      station = is_next_station
      station.take_train(self)
    else
      false
    end
  end

  def move_to_previos_station
    is_previous_station = previous_station
    if is_previous_station
      station.send_train(self)
      station = is_previous_station
      station.take_train(self)
    else
      false
    end
  end

end
