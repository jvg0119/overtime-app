#homepage_spec.rb
require 'rails_helper'

describe "Homepage" do 
	it "allows the admin to approve posts from the Homepage" do 
		post = create(:post)
		admin_user = create(:admin_user)
#		login_as(admin_user, user: admin_user)
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
end
