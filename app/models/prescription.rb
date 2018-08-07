class Prescription < ActiveRecord::Base
  belongs_to :patient

  validates :prescription_details, presence: true
end
