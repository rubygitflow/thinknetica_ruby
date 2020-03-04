class Wagon
  attr_reader :wagon_type, :train_number 

  def initialize(wagon_type)
    @wagon_type = wagon_type
  end

  def include_to_train(train_number)
    @train_number = train_number
  end

end
