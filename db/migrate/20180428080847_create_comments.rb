class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user
      t.references :place
      t.text :content
      t.references :parent, null: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
