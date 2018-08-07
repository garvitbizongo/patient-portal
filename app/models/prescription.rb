class Prescription < ActiveRecord::Base
  belongs_to :patient
  has_many :prescription_requests

  validates :prescription_details, presence: true

  scope :by_patient_id, -> (patient_id) {
    where(patient_id: patient_id)
  }
end
