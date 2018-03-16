class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :address, limit: 100, null: false
      t.string :phoneNum, limit: 10, null: false

      t.timestamps
    end
  end
end
