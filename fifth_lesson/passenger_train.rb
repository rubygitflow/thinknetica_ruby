require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter

  def initialize(number)
    super(number, :passenger)
    register_instance
  end
end
