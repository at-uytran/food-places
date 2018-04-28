class CreatePlaceImages < ActiveRecord::Migration[5.1]
  def change
    create_table :place_images do |t|
      t.references :place
      t.string :descriptions
      t.references :comment, null: true
      t.string :image_url

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
