class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :status, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end

    add_index :reservations, [:user_id, :item_id]
    add_index :reservations, :status
    add_index :reservations, :start_date
    add_index :reservations, :end_date
  end
end
