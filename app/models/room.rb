class Room < ApplicationRecord
  self.table_name = "Room"
  belongs_to :Location
end
