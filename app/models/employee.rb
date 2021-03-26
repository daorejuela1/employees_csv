class Employee < ApplicationRecord

  validates :names, presence: true
  validates :surnames, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_email_layers
  validates :telephone, presence: true, format: { with: /\A\d+\z/, message: "Sólo puedes colocar números" },length: { is: 10 }
  validates :salary, presence: true
  validates :job_title, presence: true
  validate :validate_department

  def self.departments
    ["contabilidad", "finanzas", "operaciones", "seguridad", "recursos humanos"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << self.attribute_names
      all.each do |record|
        csv << record.attributes.values
      end
    end
  end

  private

  def validate_email_layers
    errors.add(:email, 'no fué encontrado') if !Truemail.valid?(email)
  end

  def validate_department
    errors.add(:department, 'Departamento no valido') if !Employee.departments.include? (department.downcase)
  end
end
