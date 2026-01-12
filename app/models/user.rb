class User < ApplicationRecord
  has_secure_password

  has_many :sent_kudos,
           class_name: 'Kudo',
           foreign_key: :sender_id,
           dependent: :destroy

  has_many :received_kudos,
           class_name: 'Kudo',
           foreign_key: :receiver_id,
           dependent: :destroy
           
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6}
end
