class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def show
		@user=User.find(params[:id])
		if @user.nil?
			render_404
		end
	end
end
