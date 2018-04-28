class CreateCollectionPlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :collection_places do |t|
      t.string :descriptions
      t.references :place
      t.references :collection

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
