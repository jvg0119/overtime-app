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

# moved current_user_admin?() in the ApplicationController to share it w/ the controllers
	# def admin_types 
	# 	['AdminUser']
	# end

#	def admin_user?(user) # this or the one below work ## used for the homepage
	# def current_user_admin?(user)
	# 	admin_types.include?(user.try(:type))
	# end

#	ADMIN_USER_TYPE = ['AdminUser']

#	def current_user_admin?(user)  # pass the current_user here
#		ADMIN_USER_TYPE::include?(user.try(:type)) 
		# ApplicationHelper.admin_user_type.include?user.type  ## this works also
#	end

	def label_type(object) # works but not used; using status_lable instead
		case object.status
			when "submitted" then "label label-primary" 
			when "approved" then "label label-success"
			when "rejected" then "label label-danger"
		end
	end


	def status_label(status)
		status_span_generator(status)
	end

private
	def status_span_generator(status)
		case status
		when "submitted"
			content_tag(:span, status.titleize, class: "label label-primary")
		when "approved"
			content_tag(:span, status.titleize, class: "label label-success")
		when "rejected"
			content_tag(:span, status.titleize, class: "label label-danger")
		when "pending"
			content_tag(:span, status.titleize, class: "label label-primary")
		when "confirmed"
			content_tag(:span, status.titleize, class: "label label-success")
		end

	end

	# <span class="label label-default"><%#= object.status %></span> 

end
