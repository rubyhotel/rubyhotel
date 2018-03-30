class Guest < ApplicationRecord
  self.table_name = "Guest"

  validates :phoneNum, presence: true, length: {is: 10}

end
