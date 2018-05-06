class CreateDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :districts do |t|
      t.string :name
      t.references :province
      t.string :descriptions

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
