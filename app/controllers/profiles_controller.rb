class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def show
		@current=current_user
		if @current.id != params[:id].to_i
			render(:template => 'profiles/error')
		else
			@user=User.find(params[:id])
			@volunteer=VolunteerRequest.find_by_user_id(@user.id)
			@event1=Event.find_by_id(@volunteer.priority1)
			@event2=Event.find_by_id(@volunteer.priority2)
			@event3=Event.find_by_id(@volunteer.priority3)
			@event4=Event.find_by_id(@volunteer.priority4)
		end
		
	end

end
