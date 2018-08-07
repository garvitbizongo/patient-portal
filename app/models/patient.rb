class Patient < ActiveRecord::Base
  has_many :prescriptions

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

  def test_password?(password)
    self.password == password
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
