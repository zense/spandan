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
		@event=Event.find_by_name(params[:name])
		if(@event.event_type==INDIVIDUAL)
			if !current_user.has_registered_for(@event.id)
				if current_user.register(@event.id)
					#redirect_to controller: 'game', action: 'success'
				end
			end
		else
			@TeamMates=params[:team_mates]
			team = current_user.create_team(@event.id,params[:team_name])
			@team_var = team
			@TeamMates.shift
			for i in @TeamMates
				@team_var.add_user(i)
			end
		end
	end

end
