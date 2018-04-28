class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :coordinates
      t.string :descriptions
      t.text :avatar
      t.integer :status, default: 0
      t.string :password_digest
      t.string :auth_digest
      t.string :confirm_digest
      t.boolean :activated, default: false
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
