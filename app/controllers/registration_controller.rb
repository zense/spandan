class RegistrationController < ApplicationController
	before_action :authenticate_user!

	# default home page
	def index
		# To display or not to display the volunteer signup link
		if VolunteerRequest.exists?(:user_id => current_user.id)
		  @showVolunteerLink = false
		else
		  @showVolunteerLink = true
		end
	end

	def volunteer_registration

		# Array of constants
		@event_array = [['1',1],['2',2],['3',3],['4',4]]
		@tshirt_sizes = [['S',1],['M',2],['L',3],['XL',4],['XXL',5]]

		@VolunteerRequest = VolunteerRequest.new

	end

	def volunteer_registration_process

		@VolunteerRequest = VolunteerRequest.new(volunteer_params)
		@VolunteerRequest.user_id = current_user.id

		# Array of constants
		@event_array = [['1',1],['2',2],['3',3],['4',4]]
		@tshirt_sizes = [['S',1],['M',2],['L',3],['XL',4],['XXL',5]]

		if @VolunteerRequest.save
		  # May be show a volunteer registration done page with further instructions?
		  render 'volunteer_success'
		  #redirect_to controller: 'registration', action: 'index'
		else
		  render 'volunteer_registration'
		end

	end

end

private
  def volunteer_params
    params.permit(:priority1, :priority2, :priority3, :priority4, :tshirt_size)
  end