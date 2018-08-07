class PrescriptionRequest < ActiveRecord::Base
  belongs_to :doctor_pharmacist
  belongs_to :prescription

  enum status: [:unapproved, :approved]
end
