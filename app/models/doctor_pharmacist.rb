class DoctorPharmacist < ActiveRecord::Base
  include CommonModelMethods
  has_many :prescription_request

  enum status: [:inactive, :active]
  enum role: [:doctor, :pharmacist]

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :contact_number, presence: true, length: { minimum: 10, maximum: 15 }

  before_save :ensure_auth_token
end
