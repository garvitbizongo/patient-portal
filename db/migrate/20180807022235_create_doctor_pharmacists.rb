class CreateDoctorPharmacists < ActiveRecord::Migration
  def change
    create_table :doctor_pharmacists do |t|
      t.string :email, null: false, default: ""
      t.string :password, null: false, default: ""
      t.string :first_name
      t.string :last_name
      t.integer :status, default: 0
      t.string :contact_number
      t.string :auth_token
      t.string :speciality
      t.string :hospital_address
      t.string :store_address
      t.integer :role

      t.timestamps null: false
    end
  end
end
