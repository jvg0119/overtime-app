class StaticController < ApplicationController
#  before_action :authenticate_user!

def homepage
#	byebug
#	@pending_approvals = Post.where(status: 'submitted') # this only worked for submitted
						# if I changed it to 'approved' or 'rejected' it always acted like 'submitted'
#	@pending_approvals = Post.where(status: 1) # 0, 1, & 2 worked fine (correctly)
#	@pending_approvals = Post.submitted # this way works correctly also; this would be the prefered way 
#	if current_user.type == "AdminUser"
	if current_user_admin?(current_user)	
		@pending_approvals = Post.submitted 
		@recent_audit_items = AuditLog.last(10)
	else
		# something else
	end
end

end