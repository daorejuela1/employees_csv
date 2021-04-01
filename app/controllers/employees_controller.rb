class EmployeesController < ApplicationController
  rescue_from CSV::MalformedCSVError, with: :bad_file
  rescue_from ActiveRecord::RecordInvalid, with: :bad_file

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
        no_import_file
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

  def no_import_file
      redirect_to request.referer, alert: "Indique un archivo"
  end

  def bad_file
    redirect_to request.referer, alert: "Archivo no valido"
  end
end
