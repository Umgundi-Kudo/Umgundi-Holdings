class AddEmailVerificationTokenAndSentAtToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email_verification_token, :string
    add_column :users, :email_verification_sent_at, :datetime

    add_index :users, :email_verification_token, unique: true
  end
end
