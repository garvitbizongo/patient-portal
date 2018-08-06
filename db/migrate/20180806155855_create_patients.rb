class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :email, null: false, default: ""
      t.string :password, null: false, default: ""
      t.string :first_name
      t.string :last_name
      t.integer :status, default: 0
      t.string :contact_number
      t.string :auth_token

      t.timestamps null: false
    end
  end
end
