class CreateUserRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_ratings do |t|
      t.string :title
      t.references :user
      t.references :place
      t.integer :points, default: 0
      t.text :content
      t.integer :score_price
      t.integer :score_location
      t.integer :score_quality
      t.integer :score_serve
      t.integer :score_space
      t.boolean :turn_back

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
