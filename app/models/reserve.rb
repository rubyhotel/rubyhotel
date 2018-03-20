class Reserve < ApplicationRecord
  belongs_to :Booking
  belongs_to :Location
  belongs_to :Room
  belongs_to :Guest
end
