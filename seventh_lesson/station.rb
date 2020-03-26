class Station
  include InstanceCounter
  include Validator

  attr_reader :name, :trains, :wagons 

  INCLUDE_SYMBOL_EXAMPLE = /^[a-zа-я0-9\s\-]{3,}/i.freeze
  EXCLUDE_SYMBOL_EXAMPLE = /[\W][^а-я0-9\s\-]+/i.freeze

  @@stations = []

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
    wagons.select {|element| element.type == type}
  end

  def trains_by_type(type)
    trains.select {|element| element.type == type}
  end

  def self.all
    @@stations
  end

  def self.sort
    @@stations.sort_by {|x| [x.name]}
  end

  def self.get_station_by_train(train)
    station_object = nil
    train_type = train.type
    @@stations.each_with_index do |station, index|
      unless station.trains_by_type(train_type).index(train).nil?
        station_object = station
        break
      end
    end
    station_object
  end

  def wagons_list(type)
    wagons_by_type(type).each_with_index { |wagon, index| yield(wagon, index + 1) }
  end

  def trains_list(type)
    trains_by_type(type).each_with_index { |train, index| yield(train, index + 1) }
  end

  private

  def validate!
    validate_name!
  end
  
  def validate_name!
    raise "Name has invalid format" if name !~ INCLUDE_SYMBOL_EXAMPLE || name =~ EXCLUDE_SYMBOL_EXAMPLE  
  end

end
