class Prescription < ActiveRecord::Base
  belongs_to :patient
  has_many :prescription_requests

  validates :prescription_details, presence: true
end
