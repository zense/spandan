class GameController < ApplicationController
	# before_action :authenticate_user!
	# before_action :game, only: [:show, :edit]

	def index
		@game=Event.all
	end

	def show

#	@event=Event.find_by_name("cricket")
		@searched=""
		if(params[:name]=="game_path")
			email=params[:search]
			@searched=params[:search]
		#	render plain: params
			@user=User.find_by_email(email)
			@event=Event.find_by_name(params[:names])
			#@x=@user.id
		#	@team=Teams_user.find_by_user_id(@user.id)

			@arr=[]
			if @user.nil?
				@tasks_grid = initialize_grid(Schedule.where("event_id=0"),per_page: 20, enable_export_to_csv: true,  csv_file_name:'schedule')
			else
				if(@event.event_type.to_i ==1)
						Teams_user.where("user_id=?",@user.id).find_each do |user|
								@arr.append(user.team_id)
								end
				else
						@arr.append(@user.id)
					end
			#@team=Schedule.where("party1=? OR party2=?",@arr,@arr)
			#render plain: @team

			@tasks_grid = initialize_grid(Schedule.where("event_id=?",@event.id),per_page: 20, enable_export_to_csv: true,  csv_file_name:'schedule',conditions: ['party1 IN (?) OR party2 IN (?)', @arr,@arr]
)
		end
		else
				@event=Event.find_by_name(params[:name])
				if @event.nil?
					render_404
				end
			@tasks_grid = initialize_grid(Schedule.where("event_id=?",@event.id),per_page: 20, enable_export_to_csv: true,  csv_file_name:'schedule')
end


	#	if @event.event_type.to_i == 1
	#		@t
	#	else
	#		@team=User.all
	#			end#
	#	@schedule=Schedule.where(event_id: @event.id)


		#@tasks_grid = initialize_grid(Schedule.where(event_id: @event.id),per_page: 20, enable_export_to_csv: true,  csv_file_name:'schedule')

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
