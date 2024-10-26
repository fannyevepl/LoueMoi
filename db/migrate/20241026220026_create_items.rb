class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.string :category, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :items, [:user_id, :name]
    add_index :items, :category
  end
end
