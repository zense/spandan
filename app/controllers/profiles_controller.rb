class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def show
		@user=User.find(params[:id])
		@tasks_grid = initialize_grid(Schedule, per_page: 20, conditions: ['((party1 = (?) OR party2 = (?)))', current_user.email, current_user.email])
		# @arr=[]
		# @arreve=[]
		# @arrind=[]
		# Event.find_each do |eve|
		# 		if eve.event_type.to_i ==1
		# 				@arreve.append(eve.id)
		# 		else
		# 				@arrind.append(eve.id)
		# 			end
		# 		end
		# Teams_user.where("user_id=?",@user.id).find_each do |user|
		# 					@arr.append(user.team_id)
		# 					end
		# 				#	@arr.append(@user.id)
		# @tasks_grid = initialize_grid(Schedule,per_page: 20,conditions: ['((party1 IN (?) OR party2 IN (?)) AND event_id IN (?)) OR ((party1 = ? OR party2=?) AND event_id IN (?)) ', @arr,@arr,@arreve,@user.id,@user.id,@arrind])
    #
		# #@tasks_grid = initialize_grid(Schedule.where(party1: @user.team.id),per_page: 20, enable_export_to_csv: true,  csv_file_name:'schedule')
		if @user.nil?
			render_404
		end
	end
end
