class CreateFoodCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :food_categories do |t|
      t.string :name
      t.references :parent, null: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
