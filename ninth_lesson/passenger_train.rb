# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter
  include Library

  class << self
    include Library
    
    def all
      @@trains.select { |element| element.type == PASSENGER }
    end
  end

  def initialize(number)
    super(number, PASSENGER)
    register_instance
  end
end
