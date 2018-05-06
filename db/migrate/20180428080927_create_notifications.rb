class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
