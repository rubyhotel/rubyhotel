json.extract! guest, :id, :name, :phoneNum, :creditCardNum, :created_at, :updated_at
json.url guest_url(guest, format: :json)
