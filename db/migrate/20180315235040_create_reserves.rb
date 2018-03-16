class CreateReserves < ActiveRecord::Migration[5.1]
  def change
    create_table :reserves do |t|
      t.references :Booking, foreign_key: true, null: false
      t.references :Location, foreign_key: true, null: false
      t.references :Room, foreign_key: true, null: false
      t.references :Guest, foreign_key: true, null: false

      t.timestamps
    end
  end
end
