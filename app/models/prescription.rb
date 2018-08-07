class Prescription < ActiveRecord::Base
  belongs_to :patient
  has_many :prescription_request

  validates :prescription_details, presence: true
end
