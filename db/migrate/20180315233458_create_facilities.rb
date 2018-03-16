class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.string :name, limit:30
      t.string :type, limit: 30, null: false
      t.integer :price, null: false
      t.references :Location, foreign_key: true, null: false

      t.timestamps
    end
  end
end
