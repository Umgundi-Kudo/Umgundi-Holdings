class AddConstraintsToKudos < ActiveRecord::Migration[7.0]
  def change
    change_column_null :kudos, :sender, false
    change_column_null :kudos, :receiver, false
    change_column_null :kudos, :message, false
  end
end

