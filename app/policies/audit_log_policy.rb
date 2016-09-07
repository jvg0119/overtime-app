class AuditLogPolicy < ApplicationPolicy

  def index?
  	return true if admin?
#  	true
#     admin?  # this works also
  end

  def confirm?
  	user.present? && record.user == user   ## same as below only the owner have access
  #	record.user_id == user.id

  # false ## no access 
  #	return true ## access for anyone
  end

private 

  # def admin?
  #   admin_types.include?(user.type)
  # end


end