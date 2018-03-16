class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :name, limit: 100, null: false
      t.string :phoneNum, limit: 10, null: false
      t.string :creditCardNum, limit: 16, null: false

      t.timestamps
    end
  end
end
