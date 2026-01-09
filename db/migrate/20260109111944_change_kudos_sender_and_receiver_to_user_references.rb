class ChangeKudosSenderAndReceiverToUserReferences < ActiveRecord::Migration[7.1]
  def change
    # First, remove the old string columns
    remove_column :kudos, :sender, :string
    remove_column :kudos, :receiver, :string
    remove_column :kudos, :sender_id, :uuid
    remove_column :kudos, :receiver_id, :uuid
    # Add references to users with UUIDs
    add_reference :kudos, :sender, type: :uuid, foreign_key: { to_table: :users }
    add_reference :kudos, :receiver, type: :uuid, foreign_key: { to_table: :users }
  end
end