# approval_workflow_spec.rb
require 'rails_helper'

describe 'Navigate' do

	let(:admin_user_login) { sign_in2(create(:admin_user)) }
	let(:user_login) { sign_in2(create(:user)) }
	let(:post) { create(:post) }
	
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
			
			expect(current_path).to eq(root_path)
			expect(page).to_not have_content("Submitted")
		#	no need to go further since you cannot select the status here
		#	save_and_open_page
		end
	end
		

end

