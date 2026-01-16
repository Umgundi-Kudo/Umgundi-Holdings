class User < ApplicationRecord
  has_secure_password

  has_many :sent_kudos,
           class_name: "Kudo",
           foreign_key: :sender_id,
           dependent: :destroy

  has_many :received_kudos,
           class_name: "Kudo",
           foreign_key: :receiver_id,
           dependent: :destroy

  before_validation :normalize_email

  validates :username, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end
end
