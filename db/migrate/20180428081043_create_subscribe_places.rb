class CreateSubscribePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribe_places do |t|
      t.references :user
      t.references :place
      t.integer :status, default: 0

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
