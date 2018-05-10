class CreatePlaceSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :place_settings do |t|
      t.boolean :allow_order, default: false
      t.boolean :enable, dafault: true
      t.references :place

      t.timestamps
    end
  end
end
