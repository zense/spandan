json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :rules, :minimum_team_size, :maximum_team_size, :contact_details, :last_date, :event_type
  json.url event_url(event, format: :json)
end
