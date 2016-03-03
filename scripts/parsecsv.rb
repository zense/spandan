require ENV['RAILS_ROOT'] + "config/environment"

def addScheduleIndividual(party1, party2, schedule, description, event)
	if event.event_type!=INDIVIDUAL
		puts "Invalid Event"
		return;
	end
	id1, id2 = User.find_by_email(party1).id, User.find_by_email(party2).id
	Schedule.create(party1: id1, party2: id2, schedule: schedule, description: description, event_id: event.id)
	puts "Individual added"
end

def addScheduleTeam(party1, party2, schedule, description, event)
	if event.event_type!=TEAM
		puts "Invalid Event"
		return;
	end
	puts "Captain1: ", party1
	puts "Captain2: ", party2

	team1 = Team.where(parent_id: User.find_by_email(party1).id, event_id: event.id)[0]
	team2 = Team.where(parent_id: User.find_by_email(party2).id, event_id: event.id)[0]

	puts team1.name
	puts team2.name
	Schedule.create(party1: team1.id, party2: team2.id, schedule: schedule, description: description, event_id: event.id)
	puts "team adding"
end

def addSchedule(party1, party2, schedule, description, event)
	Schedule.create(party1: party1, party2: party2, schedule: schedule, description: description, event_id: event.id)
	puts "Created Schedule"
end

players_text = File.read('schedule-test.csv')
players = CSV.parse(players_text, :headers=> true)


Schedule.transaction do 
	players.each do |p|
    puts p["party1"]
    puts p["party2"]
		event = Event.find(p["event_id"].to_i)
		puts event.name
		addSchedule(p["party1"], p["party2"], p["schedule"], p["description"], event)
		# if event.event_type==TEAM
     #  puts p["party1"]
     #  addScheduleTeam(p["party1"], p["party2"], p["schedule"], p["description"], event)
    # else
     #  addScheduleIndividual(p["party1"], p["party2"], p["schedule"], p["description"], event)
		# end
	end
end
