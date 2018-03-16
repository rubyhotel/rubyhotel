class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :cost, null: false
      t.datetime :inDate, null: false
      t.datetime :outDate, null: false
      t.integer :numOfGuests, null: false

      t.timestamps
    end
  end
end
