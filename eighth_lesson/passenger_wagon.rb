# frozen_string_literal: true

require_relative 'wagon'

class PassengerWagon < Wagon
  include Library

  attr_reader :max_seats, :empty_seats

  def initialize(seats = 100)
    @max_seats = seats
    @empty_seats = @max_seats
    super(PASSENGER)
  end

  def take_seat
    @empty_seats -= 1 if @empty_seats != 0
  end

  def getout_seat
    @empty_seats += 1 if empty_seats < max_seats
  end

  def occupied_seats
    max_seats - empty_seats
  end
end
