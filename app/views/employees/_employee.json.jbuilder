json.extract! employee, :id, :name, :phoneNum, :position, :hourlyRate, :startDate, :Location_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
