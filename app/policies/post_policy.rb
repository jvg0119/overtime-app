class PostPolicy < ApplicationPolicy



#	user.present? && (record.user == user || user.type == "AdminUser")
 #	user.present? && (record.user == user || user.type == "AdminUser")
	# a user is present and the record owner is the current_user or a type admin

	# record.user_id == user.id # post.user_id == current_user.id
	# record.user_id == user.id || user.type == "AdminUser"

	# record.user_id == user.id || ADMIN_TYPES::include?(user.type) # same as below but uses a constant

	 # record.user_id == user.id || admin_types.include?(user.type) # admin_types is a method defined in application_policy.rb
	 
 #  return true if admin_types.include?(user.type)
 #  return true if record.user_id == user.id  && record.status != "approved"
  
  #   (record.user_id == user.id || admin_types.include?(user.type)) && record.status != "approved"

  #  return true if record.approved? && admin_types.include?(user.type)
  #  return true if (record.user_id == user.id || admin_types.include?(user.type)) && !record.approved?

def update?
  # these 2 uses the 3 private methods below
  # return true if post_approved? && admin?
  # return true if user_or_admin && !post_approved?

  return true if post_approved? && admin?  # post is approved admin still have access
  return true if user_or_admin && !record.approved? # user owner or admin & post is not approved 
                                                    # you have access
	end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
       # user.present? && scope.where(user: user)

     #scope.user == user 
     if user.type == "AdminUser"
        scope.all
      elsif user.present?
        scope.where(user: user)
      end
    end
  end

private


  def user_or_admin
    record.user_id == user.id || admin?
  end

  def admin?
    admin_types.include?(user.type)
  end

  def post_approved?
    record.approved? 
  end

end









