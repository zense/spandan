json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :party1, :party2, :event_id, :schedule, :description, :result
  json.url schedule_url(schedule, format: :json)
end
