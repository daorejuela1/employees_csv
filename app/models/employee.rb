class Employee < ApplicationRecord

	REGEX_FOR_SALARY = /\A(\$|)\d+\z/.freeze
	validates :names, presence: true
	validates :surnames, presence: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }
	validate :validate_email_layers
	validates :telephone, presence: true, format: { with: /\A\d+\z/, message: "Sólo puedes colocar números" },length: { is: 10 }
	validates :salary, presence: true, format: {with: REGEX_FOR_SALARY, message: "Sólo puedes colocar números o iniciar con el simbolo $ para indicar pesos colombianos"}
	validates :job_title, presence: true
	validate :validate_department

	def self.departments
		return colors = {
			primary: "Contabilidad",
			success: "Finanzas",
			dark: "Operaciones",
			warning: "Seguridad",
			info: "Recursos humanos"
		}
	end

	def self.generate_csv
		CSV.generate(headers: true) do |csv|
			attributes = self.attribute_names.select {|x| !x.ends_with? ("at")}
			csv << attributes
			all.each do |record|
				csv << record.attributes.values_at(*attributes)
			end
		end
	end

	def self.import_csv(file)
		CSV.foreach(file.path, headers: true) do |row|
			employee_dict = row.to_hash
			employee = Employee.find_or_create_by!(employee_dict)
			employee.update(employee_dict)
		end
	end

	def self.search(search)
		if search 
			where(["names LIKE? or surnames LIKE? or telephone LIKE? or email LIKE? or salary LIKE? or job_title LIKE? or department LIKE?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
		else
			all
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
