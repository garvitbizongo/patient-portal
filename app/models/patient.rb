class Patient < ActiveRecord::Base
  enum status: [:inactive, :active]

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :contact_number, presence: true, length: { minimum: 10, maximum: 15 }

  before_save :ensure_auth_token

  def ensure_auth_token
    return if auth_token.present?

    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    loop do
      token = SecureRandom.hex
      break token unless Patient.where(auth_token: token).first
    end
  end
end