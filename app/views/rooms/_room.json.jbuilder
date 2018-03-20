json.extract! room, :id, :roomNum, :amenities, :isVacant, :isClean, :Location_id, :created_at, :updated_at
json.url room_url(room, format: :json)
