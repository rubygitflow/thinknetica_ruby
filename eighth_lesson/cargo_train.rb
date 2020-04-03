# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  include InstanceCounter
  include Library

  class << self
    include Library
    
    def all
      @@trains.select { |element| element.type == CARGO }
    end
  end

  def initialize(number)
    super(number, CARGO)
    register_instance
  end
end
