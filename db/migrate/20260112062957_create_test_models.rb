class CreateTestModels < ActiveRecord::Migration[7.1]
  def change
    create_table :test_models, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
