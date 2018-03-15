class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :name
      t.string :phoneNum
      t.string :creditCardNum

      t.timestamps
    end
  end
end
