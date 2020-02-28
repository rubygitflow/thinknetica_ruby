class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    if trains.include?(train)
      false
    else
      trains << train
      true
    end
  end

  def send_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select {|element| element.type == type}
  end
end
