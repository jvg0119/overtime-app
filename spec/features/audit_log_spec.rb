# audit_log_spec.rb
require 'rails_helper'

describe "AuditLog feature" do 
	let(:audit_log) { create(:audit_log) }
	let(:admin_user_login) { login_as(admin_user_var = create(:admin_user), user: admin_user_var) }
	let(:user_login) { login_as(user_var = create(:user), :scope => :user) }
	# before(:example) do 
	# 	user = create(:user)
	# 	login_as(user, user: user)
	# end

	
	describe "index" do 
		it "can be reached successfully" do
			admin_user_login
			visit(audit_logs_path)
			expect(page.status_code).to eq(200)
			expect(current_path).to eq(audit_logs_path)
			expect(page).to have_content("Audit Log Dashboard")
		end
		
		it "has a list of audit logs" do 
			admin_user_login
			audit_log
			visit(audit_logs_path)
		#	byebug
			expect(current_path).to eq(audit_logs_path)
			expect(page).to have_content(audit_log.start_date)
			expect(page).to have_content(audit_log.status.titleize)
			expect(page).to have_content(audit_log.end_date)
		#	save_and_open_page
		end

		it "cannot be accessed by non-admin users" do 
			user_login
			audit_log
			visit(audit_logs_path)

			expect(current_path).to eq(root_path)
			expect(page).to have_content("Hello, world!")
		#	save_and_open_page
		end
	end 	# describe "index"



end












