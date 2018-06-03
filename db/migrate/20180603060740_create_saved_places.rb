class CreateSavedPlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_places do |t|
      t.integer :user_id
      t.integer :place_id

      t.timestamps
    end
  end
end
