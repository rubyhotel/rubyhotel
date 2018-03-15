class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :phoneNum
      t.string :position
      t.integer :hourlyRate
      t.datetime :startDate
      t.references :Location, foreign_key: true

      t.timestamps
    end
  end
end
