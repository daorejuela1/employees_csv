class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :names
      t.string :surnames
      t.integer :telephone
      t.string :email
      t.float :salary
      t.string :job_title
      t.string :department

      t.timestamps
    end
  end
end
