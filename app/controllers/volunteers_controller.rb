class VolunteersController < ApplicationController
	before_action :set_volunteer, only: [:show]
	def new
		@volunteer = Volunteer.new
		@events = Event.all
	end
	def create
		@volunteer = Volunteer.new(post_params)
		@events = Event.all
		respond_to do |format|
			if @volunteer.save
                @volunteer.events.each do |event|
                    event.vol_req-=1
                    event.save
                end 
				flash[:notice] = "You are successfully registered for volunteer"
        		format.html { redirect_to  welcome_index_url}
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
    	params.require(:volunteer).permit(:name, :email, :roll, :tshirt_size, :event_ids =>[])
    end
    def set_volunteer
    @volunteer= Volunteer.find(params[:id]) 

  end
end
