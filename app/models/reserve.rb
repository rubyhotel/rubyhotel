class Reserve < ApplicationRecord
  self.table_name = "Reserve"
  belongs_to :Booking
  belongs_to :Location
  belongs_to :Room
  belongs_to :Guest
end
