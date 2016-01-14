json.array!(@events) do |event|
  json.extract! event, :id, :Name, :Description, :Rules, :Minimum_team_size, :Maximum_team_size, :SPOC_of_the_event, :Contact_Details
  json.url event_url(event, format: :json)
end
