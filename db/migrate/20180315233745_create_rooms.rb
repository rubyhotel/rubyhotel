class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :roomNum, null: false
      t.string :amenities, limit: 100
      t.boolean :isVacant, null: false
      t.boolean :isClean, null: false
      t.references :Location, foreign_key: true, null: false

      t.timestamps
    end
  end
end
