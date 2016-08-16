module ApplicationHelper

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


end

