class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  @namam = "sdf"
  protect_from_forgery with: :exception



  # Below code is to permit some custom fields added in devise registration
  before_filter :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :year_of_joining, :student_type, :roll_no, :phone_number) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:current_password,:phone_number,:password,:password_confirmation) }
        end
end
