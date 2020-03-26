require_relative 'train'

class CargoTrain < Train
  include InstanceCounter
  include Library

  def initialize(number)
    super(number, Cargo)
    register_instance
  end

  def self.all
    @@trains.select {|element| element.type == Cargo}
  end
end
