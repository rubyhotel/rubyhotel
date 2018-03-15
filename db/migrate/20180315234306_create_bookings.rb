class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :cost
      t.datetime :inDate
      t.datetime :outDate
      t.integer :numOfGuests

      t.timestamps
    end
  end
end
