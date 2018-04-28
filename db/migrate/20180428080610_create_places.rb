class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.text :descriptions
      t.references :province
      t.references :owner, index: true
      t.time :open_time
      t.time :close_time
      t.float :ship_price
      t.text :coordinates
      t.integer :status
      t.text :image_url
      t.references :place_category, index: true
      t.references :location, index: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
