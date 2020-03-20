require_relative 'manufacturing_company'

class Wagon
  include ManufacturingCompany

  attr_reader :wagon_type

  def initialize(wagon_type)
    @wagon_type = wagon_type
  end
end
