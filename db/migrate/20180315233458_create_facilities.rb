class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :type
      t.integer :price
      t.references :Location, foreign_key: true

      t.timestamps
    end
  end
end
