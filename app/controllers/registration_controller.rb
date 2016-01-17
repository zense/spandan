class RegistrationController < ApplicationController
	before_action :authenticate_user!

	# default home page
	def index
		
		redirect_to controller: 'welcome', action: 'index'

		# To display or not to display the volunteer signup link
		if VolunteerRequest.exists?(:user_id => current_user.id)
		  @showVolunteerLink = false
		else
		  @showVolunteerLink = true
		end
	end

	# Where user can register to volunteer
	def volunteer_registration
		if VolunteerRequest.exists?(:user_id => current_user.id)
		  @showVolunteerLink = false
		else
		 	@showVolunteerLink = true
			@event_array = []
			# add events to the array from the database
			Event.all.each do |event|
			  @event_array.push([event.name,event.id])
			end

			# Array of constants
			@tshirt_sizes = [['S',TSHIRTSIZES[:S]],['M',TSHIRTSIZES[:M]],['L',TSHIRTSIZES[:L]],['XL',TSHIRTSIZES[:XL]],['XXL',TSHIRTSIZES[:XXL]]]

			@VolunteerRequest = VolunteerRequest.new
		end
	end

	# Volunteer registration form processing
	def volunteer_registration_process
		# Validation: if selected event is in the DB
		allEventsIDs = []
		Event.all.each do |event|
			allEventsIDs.push(event.id)
		end

		# Check if selected event id in array
		if allEventsIDs.include?(params[:priority1].to_i) and allEventsIDs.include?(params[:priority2].to_i) and allEventsIDs.include?(params[:priority3].to_i) and allEventsIDs.include?(params[:priority4].to_i) 

			@VolunteerRequest = VolunteerRequest.new(volunteer_params)
			@VolunteerRequest.user_id = current_user.id

			@event_array = []
			# add events to the array from the database
			Event.all.each do |event|
			  @event_array.push([event.name,event.id])
			end

			# Array of constants
			@tshirt_sizes = [['S',TSHIRTSIZES[:S]],['M',TSHIRTSIZES[:M]],['L',TSHIRTSIZES[:L]],['XL',TSHIRTSIZES[:XL]],['XXL',TSHIRTSIZES[:XXL]]]

			if @VolunteerRequest.save
			  # May be show a volunteer registration done page with further instructions?
			  render 'volunteer_success'
			  #redirect_to controller: 'registration', action: 'index'
			else
			  render 'volunteer_registration'
			end

		else
			# If provided priority id is not in DB
			redirect_to controller: 'registration', action: 'volunteer_registration'
		end

	end

end

private
  def volunteer_params
    params.permit(:priority1, :priority2, :priority3, :priority4, :tshirt_size)
  end