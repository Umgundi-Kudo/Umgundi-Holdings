class Like < ApplicationRecord
  belongs_to :user
  belongs_to :kudo

  validates :user_id, uniqueness: { scope: :kudo_id, message: "can only like a kudo once" }
end
