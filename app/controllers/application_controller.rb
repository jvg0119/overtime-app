class ApplicationController < ActionController::Base

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

   rescue_from Pundit::NotAuthorizedError do |exception|
   #  redirect_to root_url, alert: exception.message
   		redirect_to(request.referer || root_url)  # posts_url
   		flash[:success] = "You are not authorized to edit this record."
   	#	flash[:alert] = exception.message
   end


  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # private

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(request.referrer) #|| root_path)
  # end


end
