class CreateRequestOwners < ActiveRecord::Migration[5.1]
  def change
    create_table :request_owners do |t|

      t.timestamps
    end
  end
end
