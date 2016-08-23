class PostPolicy < ApplicationPolicy

def update?
#	user.present? && (record.user == user || user.type == "AdminUser")
 #	user.present? && (record.user == user || user.type == "AdminUser")
	# a user is present and the record owner is the current_user or a type admin

	# record.user_id == user.id # post.user_id == current_user.id
	# record.user_id == user.id || user.type == "AdminUser"

	# record.user_id == user.id || ADMIN_TYPES::include?(user.type) # same as below but uses a constant
#	 record.user_id == user.id || admin_types.include?(user.type) # admin_types is a method defined in application_policy.rb
	 record.user_id == user.id || admin_types.include?(user.type)
	end
end
