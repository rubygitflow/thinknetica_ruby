require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter
  include Library

  def initialize(number)
    super(number, Passenger)
    register_instance
  end

  def self.all
    @@trains.select {|element| element.type == Passenger}
  end
end
