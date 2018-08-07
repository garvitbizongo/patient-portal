class PrescriptionRequest < ActiveRecord::Base
  belongs_to :doctor_pharmacist
  belongs_to :prescription

  enum status: [:unapproved, :approved]

  scope :by_prescription_id, -> (prescription_id) {
    where(prescription_id: prescription_id)
  }

  scope :by_doctor_pharmacist_id, -> (doctor_pharmacist_id) {
    where(doctor_pharmacist_id: doctor_pharmacist_id)
  }

  scope :by_patient_id, -> (patient_id) {
    joins(:prescription).merge(Prescription.by_patient_id(patient_id))
  }

  scope :filter, -> (options = {}) {
    query = all
    query = query.by_prescription_id(options[:prescription_id]) if options[:prescription_id].present?
    query = query.by_doctor_pharmacist_id(options[:doctor_pharmacist_id]) if options[:doctor_pharmacist_id].present?
    query = query.by_patient_id(options[:patient_id]) if options[:patient_id].present?
    query
  }
end
