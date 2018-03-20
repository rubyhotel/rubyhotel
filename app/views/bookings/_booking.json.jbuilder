json.extract! booking, :id, :cost, :inDate, :outDate, :numOfGuests, :created_at, :updated_at
json.url booking_url(booking, format: :json)
