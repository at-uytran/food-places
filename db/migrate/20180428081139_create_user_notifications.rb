class CreateUserNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :user_notifications do |t|
      t.references :user
      t.references :notification

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
