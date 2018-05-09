class CreateUserLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_locations do |t|
      t.string :address
      t.text :coordinates
      t.references :district, null: true
      t.references :user, null: true
      t.float :latitude
      t.float :longitude

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
