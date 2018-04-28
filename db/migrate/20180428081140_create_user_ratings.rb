class CreateUserRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_ratings do |t|
      t.references :user
      t.references :place
      t.integer :points, default: 0

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
