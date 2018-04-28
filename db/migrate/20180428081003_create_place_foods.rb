class CreatePlaceFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :place_foods do |t|
      t.references :place
      t.references :food

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
