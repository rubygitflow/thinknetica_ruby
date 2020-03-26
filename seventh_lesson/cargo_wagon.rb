require_relative 'wagon'

class CargoWagon < Wagon
  include Library

  attr_reader :max_volume, :empty_volume

  def initialize(volume = 10)
    @max_volume = volume.to_i
    @empty_volume = @max_volume
    super(Cargo)
  end

  def take_volume
    @empty_volume -= 1 if @empty_volume != 0
  end

  def get_out_volume
    @empty_volume += 1 if empty_volume < max_volume
  end

  def occupied_volume
    max_volume - empty_volume
  end
end
