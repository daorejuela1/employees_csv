class ChangeSalaryTypeFromEmployee < ActiveRecord::Migration[6.1]
  def change
    change_column :employees, :salary, :string
  end
end
