class GameController < ApplicationController
	 #before_action :authenticate_user!
	 #before_action :game, only: [:show, :edit]

	def index
		@game=Event.all
	end

	def show
			@event=Event.find_by_name(params[:name])
			if @event.nil?
				render_404
			else
				@tasks_grid = initialize_grid(Schedule.where("event_id=?",@event.id),per_page: 20, enable_export_to_csv: true,  csv_file_name:'schedule')
				@complete = initialize_grid(Schedule, per_page: 20)
			end
	end

	def register
		authenticate_user!
		@TeamMates=[]
		@event=Event.find_by_name(params[:name])
		# If @event.nil return 404 page
		if @event.nil?
			render_404
		end
	end

	def success
		@errors = []
		@event=Event.find_by_name(params[:name])

		if @event.nil?
			@errors << "Event not found"
		end

		if(@event.event_type==INDIVIDUAL)
			if !current_user.has_registered_for(@event.id)
				current_user.register(@event.id)
			end
		else
			@team = current_user
			current_user.create_team(@event.id, params[:team_name], params[:team_mates])
		end
	end

end
