module Library
  Cargo = 1
  Passenger = 2

  TrainTypeDescription = {
    cargo: {
      name: 'Грузовой'
    },
    passenger: {
      name: 'Пассажирский'
    }
  }

  def show_train_type_list
    puts menu_cargo
    puts menu_passenger
  end

  private

  def menu_cargo
    "#{Cargo}. Cargo"
  end

  def menu_passenger
    "#{Passenger}. Passenger"
  end
end
