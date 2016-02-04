class GameController < ApplicationController
	# before_action :authenticate_user!
	# before_action :game, only: [:show, :edit]

	def index
		@game=Event.all
	end

	def show
		@event=Event.find_by_name(params[:name])
	end

	def register
		@TeamMates=[]
		@event=Event.find_by_name(params[:name])
        @TeamMates=params[:team_mates]
	end

end
