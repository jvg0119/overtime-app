#homepage_spec.rb
require 'rails_helper'

describe "Homepage" do 
	it "allows the admin to approve posts from the Homepage" do 
		post = create(:post)
		admin_user = create(:admin_user)
	#	login_as(admin_user, user: admin_user)
		login_as(admin_user, scope: :user)
		visit(root_path)
		expect(current_path).to eq(root_path)
		expect(page).to have_content("Smith, James") 
	#	click_button("Approve")  ## this also work
	#	click_button("approve_#{post.id}")  # click_button works
		click_on("approve_#{post.id}")  # post.id is approval_pending.id
	#	click_on("approve")
		expect(current_path).to eq(root_path)	
		expect(post.reload.status).to eq('approved') # it worked w/ or w/o reload	
	#	expect(page).to_not have_content("Smith, James")
	#	save_and_open_page
	end

	it "allows the employee to change the audit log status from the homepage" do 
		user_joe = create(:user)
		audit_log = create(:audit_log, user: user_joe)
	#	audit_log = AuditLog.create(status: 0, start_date: Date.today)
		
		login_as(user_joe, scope: :user)
		visit(root_path)
		expect(current_path).to eq(root_path)

	#	click_button("confirm_#{audit_log.id}") # "audit_log_#{pending_audit_confirmation}"
		click_on("confirm_#{audit_log.id}") # "audit_log_#{pending_audit_confirmation}"
		expect(current_path).to eq(root_path)
		expect(audit_log.reload.status).to eq("confirmed")
	#	save_and_open_page
	end
end
