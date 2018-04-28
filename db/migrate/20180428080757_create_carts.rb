class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.references :order
      t.references :food, null: true
      t.integer :quantity

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
