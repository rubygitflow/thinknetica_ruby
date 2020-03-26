require_relative 'manufacturing_company'

class Wagon
  include ManufacturingCompany

  attr_reader :type

  def initialize(wagon_type)
    @type = wagon_type
  end
end
