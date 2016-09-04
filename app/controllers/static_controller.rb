class StaticController < ApplicationController
#  before_action :authenticate_user!

def homepage
	@pending_approvals = Post.where(status: 'submitted')
	@recent_audit_items = AuditLog.last(10)
	@audit_logs = AuditLog.all
end

end