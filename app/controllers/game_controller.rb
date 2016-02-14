class GameController < ApplicationController
	# before_action :authenticate_user!
	# before_action :game, only: [:show, :edit]

	def index
		@game=Event.all
	end

	def show
		@event=Event.find_by_name(params[:name])
		if @event.nil?
			render_404
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
				if current_user.register(@event.id)
					#redirect_to controller: 'game', action: 'success'
				end
			end
		else
			@team = current_user
			current_user.create_team(@event.id, params[:team_name], params[:team_mates])
		end
	end

end
