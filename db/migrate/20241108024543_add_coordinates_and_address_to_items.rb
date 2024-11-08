class AddCoordinatesAndAddressToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :address, :string
    add_column :items, :latitude, :float
    add_column :items, :longitude, :float
  end
end
