class Post < ActiveRecord::Base
	enum status: { submitted: 0, approved: 1, rejected: 2 }

	belongs_to :user

	validates :date, :rational, presence: true
	validates :overtime_request, numericality: { greater_than: 0.0 }
#	validates :rational, presence: true

	scope :posts_by, -> (user) { Post.where(user: user) }

	# after_save :confirm_audit_log, if: :submitted?
	# after_save :unconfirm_audit_log, if: :rejected?

	after_save :update_audit_log


private
	
 #	def update_audit_log
 #		audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last 
 		# first find the audit_log
 		# find the user_id of the user that is currently logged in by using self.user_id
 		# self.user_id is the user that the post belongs to	
 		# the self.date is the date associated with the post     
 		# use a range to find the start_date (self.date -7.days..self.date)   within these 7 days
 		# we add .last because "where" will return an array and we want the last element not the array
 	#	audit_log.update(status: "confirmed") # or 1 ## this is OK
 #		  audit_log.confirmed!if audit_log # added if ... to get seeds.rb to run	
							  # error: undefined method `confirmed!' for nil:NilClass
							  # this is a nil guard; I don't need it because I adjusted the 
							  # seeds.rb data so that the start date is always Saturday
							  # and when an audit_log is created it has a matching post
							  # but put the nil guard just in case
							  # do not overuse nil guards because that is bad practice
 #		end 

 	# def update_audit_log
 	# 	 audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last 
 	# 	if Post.last.rejected?
 	# 		audit_log.pending!
 	# 	else
 	# 		audit_log.confirmed!
 	# 	end
 	# end

 	# def confirm_audit_log
 	# 	audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last 
 	# 	audit_log.confirmed! if audit_log
 	# end

 	# def unconfirm_audit_log
 	# 	audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last 
 	# 	audit_log.pending! if audit_log
 	# end

 	def update_audit_log
 		audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last 
# 		audit_log = AuditLog.where(user_id: Post.last.user_id, start_date: (date - 7.days..date)).last 
# 		audit_log = AuditLog.where(user_id: user_id, start_date: (date - 7.days..date)).last 
#		audit_log = Post.last.user.audit_logs.last
		if audit_log.user.posts.last.rejected?
			audit_log.pending! if audit_log
		else
			audit_log.confirmed! if audit_log
		end  		
 	end


 end







