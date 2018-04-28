class CreateUserCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :user_collections do |t|
      t.references :user
      t.references :place
      t.text :descriptions
      t.integer :collection_type, default: 0

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
