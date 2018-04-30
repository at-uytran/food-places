class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :facebook
      t.text :descriptions
      t.references :province
      t.references :owner, index: true, null: true
      t.time :open_time
      t.time :close_time
      t.float :ship_price
      t.text :coordinates
      t.integer :status
      t.string :image
      t.integer :table_count
      t.references :place_category, index: true
      t.references :location, index: true, null: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
