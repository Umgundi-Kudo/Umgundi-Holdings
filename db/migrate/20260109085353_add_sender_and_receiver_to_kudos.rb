class AddSenderAndReceiverToKudos < ActiveRecord::Migration[7.1]
  def change
    add_column :kudos, :sender_id, :uuid, null: false
    add_column :kudos, :receiver_id, :uuid, null: false

    add_index :kudos, :sender_id
    add_index :kudos, :receiver_id
  end
end
