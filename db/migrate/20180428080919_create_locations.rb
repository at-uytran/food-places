class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.text :coordinates
      t.references :district, null: true
      t.references :place, null: true
      t.float :latitude
      t.float :longitude

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
