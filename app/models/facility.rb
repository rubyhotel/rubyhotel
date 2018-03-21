class Facility < ApplicationRecord
  self.table_name = "Facility"
  belongs_to :Location
end
