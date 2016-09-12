require 'rails_helper'

RSpec.describe AuditLog, type: :model do
	let(:audit_log) { FactoryGirl.create(:audit_log) } 
	# before do 
	# 	@audit_log = FactoryGirl.create(:audit_log)
	# end
	describe "creation" do
		it "can be properly created" do 
			expect(audit_log).to be_valid
		end
	end

	describe "validations" do 
		it "required to have a user association" do 
			audit_log.user = nil
			expect(audit_log).to be_invalid
		end
		it "required to have a status" do 
			audit_log.status = nil
			expect(audit_log).to be_invalid		
		end
		it "required to have a start date" do 
			audit_log.start_date = nil
			expect(audit_log).to be_invalid		
		end
		it "required to have a start date 6 days prior" do 

			user = create(:user)
			new_audit_log = AuditLog.create(user_id: User.last.id)
		#	new_audit_log = AuditLog.create(user_id: user.id)   # OK
			# let was not connected or triggered so there was no user
			# using the before had a user so it worked
			# you could just remove the id like this: (user: User.last)
		#	p User.last
			expect(new_audit_log.start_date).to eq(Date.today - 6.days)
		end
	end




end
