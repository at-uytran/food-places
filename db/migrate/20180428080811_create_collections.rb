class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :image
      t.string :name

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
