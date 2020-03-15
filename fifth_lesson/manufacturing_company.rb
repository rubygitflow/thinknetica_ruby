module ManufacturingCompany
  def insert_company(name)
    self.company_name = name
  end

  def company
    self.company_name
  end

  protected
  attr_accessor :company_name
end
