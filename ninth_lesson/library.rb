# frozen_string_literal: true

module Library
  CARGO = 1
  PASSENGER = 2

  TRAIN_TYPE_DESCRIPTION = {
    cargo: {
      name: 'Грузовой'
    },
    passenger: {
      name: 'Пассажирский'
    }
  }.freeze

  def show_train_type_list
    puts menu_cargo
    puts menu_passenger
  end

  private

  def menu_cargo
    "#{CARGO}. Cargo"
  end

  def menu_passenger
    "#{PASSENGER}. Passenger"
  end
end
