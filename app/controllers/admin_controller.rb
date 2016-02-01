class AdminController < ApplicationController
	before_action :authenticate_user!

	# Default homepage
	def index
		checkIfAdmin()
		respond_to do |format|
			format.csv
			format.html
		end

		# Stats data collection
		@numEvents = 0
		Event.all.each do |u|
		    @numEvents = @numEvents + 1
		end

		# Various counters to count number of registrations
		@numRegs = 0
		@numAlumni = 0
		@numMTech = 0
		@numIMtech = 0
		User.all.each do |u|
		    @numRegs = @numRegs + 1
		    if u.student_type == 'mtech'
		    	@numMTech = @numMTech + 1
		    elsif u.student_type == 'imtech'
		    	@numIMtech = @numIMtech + 1
		    elsif u.student_type == 'alumni'
		    	@numAlumni = @numAlumni + 1
		    end
		end

	end

	# Look at all the volunteers
	def volunteers
		checkIfAdmin()

		@tasks_grid = initialize_grid(VolunteerRequest,per_page: 20, enable_export_to_csv: true,  csv_file_name:'volunteer-requests', include: :user)
#	@tasks_grid = initialize_grid(VolunteerRequest,per_page: 40)
		 export_grid_if_requested
		#@requests = VolunteerRequest.all

	end

	# Mass volunteer approval
	def massvolunteers
		checkIfAdmin()
	end

	# Process Mass volunteer approval
	def massvolunteersprocess
		checkIfAdmin()

		# data will be like this:
		# 12,22+562,123+228 so on
		# here 12,22 => 12 is the volunteer request ID, 22 is the event ID to be assigned to

		# Splitting data
		@rawData = params[:data].split('+')
		@rawData.each do |d|
			@data = d.split(',')

			@vrid = @data[0].to_i
			@event_id = @data[1].to_i

			@vr = VolunteerRequest.find(@vrid)

			allEventsIDs = []
			Event.all.each do |event|
				allEventsIDs.push(event.id)
			end

			# Make volunteer only if event present in the DB
			if allEventsIDs.include?(@event_id)
				@user = User.find(@vr.user_id)
				@user.update(volunteer: true)
				@user.update(volunteer_event_id: @event_id)
				@vr.update(approved: true)
				@vr.update(event_id: @event_id)
				@vr.update(approved_by: current_user.id)

				# Send an email to the volunteer
				@eventName = Event.find(@event_id).name
				Volunteermailer.became_volunteer_email(@user.email, @eventName).deliver_later
			end
		end

		redirect_to controller: 'admin', action: 'volunteers'
	end

	# Volunteer approval
	def volunteer_approve
		checkIfAdmin()
	#	render plain: params.inspect
		@vrid = params["vrid"].to_i
		@event_id = params[:event_id].to_i

		@vr = VolunteerRequest.find(@vrid)

		# Find all event IDs
		allEventsIDs = []
		Event.all.each do |event|
			allEventsIDs.push(event.id)
		end

		# Make volunteer only if event present in the DB
		if allEventsIDs.include?(@event_id)
			@user = User.find(@vr.user_id)
			@user.update(volunteer: true)
			@user.update(volunteer_event_id: @event_id)
			@vr.update(approved: true)
			@vr.update(event_id: @event_id)
			@vr.update(approved_by: current_user.id)

			# Send the volunteer an email
			@eventName = Event.find(@event_id).name
			Volunteermailer.became_volunteer_email(@user.email, @eventName).deliver_later
		end
		redirect_to controller: 'admin', action: 'volunteers'
	end

	# Un-Volunteer someone
	def volunteer_disapprove
		checkIfAdmin()
		@vrid = params[:vrid].to_i

		@vr = VolunteerRequest.find(@vrid)

		@user = User.find(@vr.user_id)

		@user.update(volunteer: false)
		@user.update(volunteer_event_id: 0)
		@vr.update(approved: false)
		@vr.update(event_id: 0)
		@vr.update(approved_by: current_user.id)

		redirect_to controller: 'admin', action: 'volunteers'
	end
end

private

	def checkIfAdmin()
		if current_user.user_type != "admin"
			redirect_to controller: 'registration', action: 'index'
		end
	end
