require 'rails_helper'

describe 'navigate' do
	before(:example) do 
		user = build(:user)
		login_as(user, scope: :user)
	end

	describe 'homepage' do 
		it 'can be reached successfully' do 
			visit(root_path)
			expect(page.status_code).to eq(200)
			expect(page).to have_content("Hello") # not necessary one above is good enough
		#	save_and_open_page
		end
	end
end
