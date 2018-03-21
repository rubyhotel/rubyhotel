class Employee < ApplicationRecord
  self.table_name = "Employee"
  belongs_to :Location
end
