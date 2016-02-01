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
		@event=Event.find_by_name(params[:name])
	end

end
