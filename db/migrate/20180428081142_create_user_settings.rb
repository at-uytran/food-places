class CreateUserSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_settings do |t|
      t.references :user
      t.text :notification_settings

      t.timestamps
    end
  end
end
