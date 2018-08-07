class Patient < ActiveRecord::Base
  include CommonModelMethods
  has_many :prescriptions

  enum status: [:inactive, :active]

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :contact_number, presence: true, length: { minimum: 10, maximum: 15 }

  before_save :ensure_auth_token
end
