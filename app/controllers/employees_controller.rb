class EmployeesController < ApplicationController

  before_action :set_departments, only: [:new, :create]

  def index
    @employee = Employee.search(params[:search])
    @colors_map = Employee.departments
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to root_path, notice: "Empleado creado!"
    else
      render :new
    end
  end

  def export
    send_data Employee.generate_csv, filename: "Empleados-#{Date.today}.csv"
  end

  def import
    if params[:file].nil?
      redirect_to request.referer, alert: "Indique un archivo"
    else
      Employee.import_csv(params[:file])
      redirect_to root_path, notice: "Empleados importados"
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:names, :surnames, :telephone, :email, :salary, :job_title, :department)
  end

  def set_departments
    @departments = Employee.departments.values.map(&:capitalize)
  end
end
