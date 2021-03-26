class EmployeesController < ApplicationController
  def index
    @employee = Employee.all
  end

  def new
    @employee = Employee.new
    @departments = Employee.departments.map(&:capitalize)
  end

  def create
    @departments = Employee.departments.map(&:capitalize)
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to root_path, notice: "Empleado creado!"
    else
      render :new
    end
  end

  def send_csv
    send_data Employee.generate_csv, filename: "Empleados-#{Date.today}.csv"
  end

  private

  def employee_params
    params.require(:employee).permit(:names, :surnames, :telephone, :email, :salary, :job_title, :department)
  end
end
