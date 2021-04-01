module EmployeesHelper
  def to_currency(salary)
    salary.starts_with?("$") ? number_to_currency(salary[1..-1], precision: 2, separator: ',', delimiter: '.', raise: true) : salary
  end

  def to_phone(phone)
    number_to_phone(phone, area_code: true)
  end
end
