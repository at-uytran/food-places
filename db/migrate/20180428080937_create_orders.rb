class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :place
      t.references :user
      t.integer :status, default: 0
      t.integer :payment_status, default: 0
      t.string :address
      t.float :ship_price
      t.float :total_price
      t.float :distance

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
