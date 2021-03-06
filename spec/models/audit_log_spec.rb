require 'rails_helper'

RSpec.describe AuditLog, type: :model do
#	let(:audit_log) { FactoryGirl.create(:@audit_log) } 
	before do 
		@audit_log = FactoryGirl.create(:audit_log)
	end
	describe "creation" do
		it "can be properly created" do 
			expect(@audit_log).to be_valid
		end
	end

	describe "validations" do 
		it "required to have a user association" do 
			@audit_log.user = nil
			expect(@audit_log).to be_invalid
		end
		it "required to have a status" do 
			@audit_log.status = nil
			expect(@audit_log).to be_invalid		
		end
		it "required to have a start date" do 
			@audit_log.start_date = nil
			expect(@audit_log).to be_invalid		
		end
		it "required to have a start date 6 days prior" do 

		#	new_@audit_log = AuditLog.create(user: User.last) # similar to one below
			new_audit_log = AuditLog.create(user_id: User.last.id)
			expect(new_audit_log.start_date).to eq(Date.today - 6.days)
			p User.last
		end
	end




end
