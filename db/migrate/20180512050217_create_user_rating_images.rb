class CreateUserRatingImages < ActiveRecord::Migration[5.1]
  def change
    create_table :user_rating_images do |t|
      t.string :image
      t.string :descriptions
      t.references :user_rating

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
