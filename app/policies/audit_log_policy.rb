class AuditLogPolicy < ApplicationPolicy

  def index?
  	return true if admin?
    # admin?  this works also
  end

private 

  # def admin?
  #   admin_types.include?(user.type)
  # end


end