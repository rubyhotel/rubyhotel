class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :roomNum
      t.string :amenities
      t.boolean :isVacant
      t.boolean :isClean
      t.references :Location, foreign_key: true

      t.timestamps
    end
  end
end
