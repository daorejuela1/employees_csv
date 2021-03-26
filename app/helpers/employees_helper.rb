module EmployeesHelper
  def to_currency(salary)
    @salary = number_to_currency(salary, :precision => 2, :separator => ',', :delimiter => '.')
  end

  def to_phone(phone)
    @phone = number_to_phone(phone, :area_code => true)
  end
end
