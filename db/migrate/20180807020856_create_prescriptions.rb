class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.references :patient, index: true

      t.string :prescription_details

      t.timestamps null: false
    end
  end
end
