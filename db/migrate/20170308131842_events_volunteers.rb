class EventsVolunteers < ActiveRecord::Migration
  def change
  	create_table :events_volunteers, :id =>false do |t|
  		t.integer :event_id
  		t.integer :volunteer_id
  	end
  end
end
