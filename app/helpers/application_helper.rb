module ApplicationHelper

	ADMIN_USER_TYPE = ['AdminUser']
	
	# def self.admin_user_type 
	# 	['AdminUser']
	# end

	def active?(path)
		"active" if current_page?(path)
	end

	def format_post(user)   # custom helper for the post _form; decided not to use it
		if user.new_record?
			"Create New User Account"
		else
			"Update User Account"
		end
	end

	def current_user_admin?(user)
		ADMIN_USER_TYPE::include?user.type 
	#	ApplicationHelper.admin_user_type.include?user.type  ## this works also
	end

end

