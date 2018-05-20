class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :phone
      t.string :address
      t.references :district, index: true, null: true
      t.float :latitude
      t.float :longitude
      t.string :coordinates
      t.string :descriptions
      t.string :avatar
      t.integer :status, default: 0
      t.string :password_digest
      t.string :auth_digest
      t.string :confirm_digest
      t.boolean :activated, default: false
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.string :remember_digest
      t.integer :user_type, default: 0

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
