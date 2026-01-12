class Kudo < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  CATEGORIES = %w[Leadership Teamwork Gratitude Innovation].freeze

  validates :message, presence: true, length: { maximum: 500 }
  validates :category, inclusion: { in: CATEGORIES }

  validate :different_sender_and_receiver

  scope :sent_by,     ->(user) { where(sender: user) }
  scope :received_by, ->(user) { where(receiver: user) }

  private

  def different_sender_and_receiver
    return if sender_id != receiver_id

    errors.add(:receiver, "can't be the same as sender")
  end
end
