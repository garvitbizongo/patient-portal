class CreatePrescriptionRequests < ActiveRecord::Migration
  def change
    create_table :prescription_requests do |t|
      t.references :prescription, index: true
      t.references :doctor_pharmacist, index: true

      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
