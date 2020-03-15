class Station
  include InstanceCounter

  attr_reader :name, :trains, :passenger_wagons, :cargo_wagons

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @passenger_wagons = []
    @cargo_wagons = []
    @@stations << self
    register_instance
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

  self.all
    @@stations
  end
end
