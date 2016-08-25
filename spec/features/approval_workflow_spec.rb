# approval_workflow_spec.rb
require 'rails_helper'

describe 'Navigate' do

	let(:user) { create(:user) }

	let(:admin_user_login) { sign_in2(create(:admin_user)) }
	let(:user_login) { sign_in2(user) }
#	let(:user_login) { login_as(user, user: :user) }
	#	login_as(user_var, user: :user)

	let(:post) { create(:post, user: user) }
	
	describe 'edit' do 
		it 'has a status that can be edited on the form by an admin' do
		# 'allows the admin to edit status'
			logout(:user)
			admin_user_login
			post 
			visit(edit_post_path(post))
		 	expect(page).to have_content("Submitted")

			choose 'post_status_approved' #'id'
			click_on 'Update Post'

			expect(post.reload.status).to eq('approved')
		#	when doing a check after a DB change you have to call reload 
		#	save_and_open_page
		end
		it 'has a status that cannot be accessed or edited by a non admin' do 
		# 'does not allow the non-admin or regular users to edit status'
			logout(:admin_user)
			user_login
			post
			visit(edit_post_path(post))
			
			expect(current_path).to eq(edit_post_path(post)) # it should go to edit page but w/o the status buttons
			expect(page).to_not have_content("Submitted")
		#	no need to go further since you cannot select the status here
		#	save_and_open_page
		end

		it "cannot be updated by the post owner if the status is approved" do 
		#"is not be editable by the post creator if the status is approved" do 
		#	post = create(:post, user: user, status: "approved") # "approved"
			post
			user_login
		#	visit(posts_path)
			post.update(user: user, status:"approved") 
		#	visit(posts_path)
			visit(edit_post_path(post))
			expect(current_path).to eq(root_path)
		#	save_and_open_page
		end
		it "can be updated by the admin user even if the status is approved" do 
		#"is not be editable by the post creator if the status is approved" do 
		#	post = create(:post, user: user, status: "approved") # "approved"
			post
			admin_user_login
		#	visit(posts_path)
			post.update(user: user, status:"approved") 
		#	visit(posts_path)
			visit(edit_post_path(post))
			expect(current_path).to eq(edit_post_path(post))
		#	save_and_open_page
		end	
	end
		

end

