class VolunteersController < ApplicationController
	befor_action :set_studentfeed, only: [:show]
	def new
		@volunteer = Volunteer.new
		@events1 = Event.all
		@events = @events1.select("name")
	end
	def create
		@volunteer = Volunteer.new(post_params)
		@events = Event.all
		respond_to do |format|
			if @Volunteers.save 
				flash[:notice] = "Widget was successfully created."
        		format.html { redirect_to student_reviews_index_url}
        	else
        		format.html { render :new }
        		format.json { render json: @events.errors, 
        			status: :unprocessable_entity }
        	end
        end
    end
    def show
    end
    private
    def post_params
    	params.require(:volunteer).permit(:name, :email, :roll, :tshirt_size)
    end
    def set_volunteer
    @studentfeed= StudentFeed.find(params[:id]) 

  end
end
