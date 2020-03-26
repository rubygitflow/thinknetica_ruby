require_relative 'wagon'

class PassengerWagon < Wagon
  include Library

  attr_reader :max_seats, :empty_seats

  def initialize(seats = 100)
    @max_seats = seats.to_i
    @empty_seats = @max_seats
    super(Passenger)
  end

  def take_seat
    @empty_seats -= 1 if @empty_seats != 0
  end

  def get_out_seat
    @empty_seats += 1 if empty_seats < max_seats
  end

  def occupied_seats
    max_seats - empty_seats
  end
end
