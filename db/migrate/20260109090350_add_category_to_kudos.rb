class AddCategoryToKudos < ActiveRecord::Migration[7.1]
  def change
    add_column :kudos, :category, :string, null: false, default: "general"
  end
end
