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

	def current_user_admin?(user)  # pass the current_user here
		ADMIN_USER_TYPE::include?(user.try(:type)) 
	#	ApplicationHelper.admin_user_type.include?user.type  ## this works also
	end

	def label_type(object) # not used
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
		end
	end

	# <span class="label label-default"><%#= object.status %></span> 

end
