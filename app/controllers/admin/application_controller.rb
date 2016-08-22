# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  def self.admin_types
    ['AdminUser']
  end

  ADMIN_TYPES = ['AdminUser']

  class ApplicationController < Administrate::ApplicationController
 #   before_filter :authenticate_admin
    before_action :authenticate_user! # 1 ensures that a user is signed in; needs to be before authenticate_admin
    before_filter :authenticate_admin


    def authenticate_admin # 2 ensures that only admin type user will access admin dashboard
      # TODO Add authentication logic here.
      #  unless current_user && current_user.type == "AdminUser" # gives the similar result as using .try
      #  unless current_user.try(:type) == "AdminUser"
        unless  Admin.admin_types.include?(current_user.try(:type))
      #   unless ADMIN_TYPES.include?current_user.try(:type) # this works also using constants
      #   unless current_user == "AdminUser"  # this may get nil problems
          flash[:notice] = "You are not authorized to access this page"
          redirect_to root_path
        end
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
