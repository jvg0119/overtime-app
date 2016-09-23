class ApplicationController < ActionController::Base

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

   rescue_from Pundit::NotAuthorizedError do |exception|
   #  redirect_to root_url, alert: exception.message
   		redirect_to root_url #(request.referer || root_url)  # posts_url
   		flash[:notice] = "You are not authorized to edit this record."
   	#	flash[:alert] = exception.message
   end


  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # private

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(request.referrer) #|| root_path)
  # end


private

  def admin_types 
    ['AdminUser']
  end

  # def current_user_admin?(user)
  #   admin_types.include?(user.try(:type))
  # end
  # helper_method :current_user_admin?

  def admin?
    admin_types.include?(current_user.try(:type))    
  end
  helper_method :admin?  


  def employee?
    current_user.type == "Employee" if current_user
  end
  helper_method :employee?


end






