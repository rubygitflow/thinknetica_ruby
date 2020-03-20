require_relative 'train'
require_relative 'instance_counter'

class CargoTrain < Train
  include InstanceCounter

  def initialize(number)
    super(number, :cargo)
    register_instance
  end
end
