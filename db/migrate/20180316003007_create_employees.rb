class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name, limit: 100, null: false
      t.string :phoneNum, limit: 10, null: false
      t.string :position, limit: 100, null: false
      t.float :hourlyRate, null: false
      t.datetime :startDate, null: false
      t.references :Location, foreign_key: true, null: false

      t.timestamps
    end
  end
end
