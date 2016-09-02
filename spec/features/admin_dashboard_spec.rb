# admin_dashboard_spec.rb
require 'rails_helper'

describe "Admin dashboard" do 
	it "can be reached successfully" do # test w/o the redirecting; pass as long as there is a page
		visit(admin_root_path) 			# this can be remove later; only an initial check
		expect(page.status_code).to eq(200)
	end
	it "does not allow users to access without being signed in" do # fail first then add the sign in authentication
		visit admin_root_path  									   # before_action :authenticate_user!   in 
		expect(current_path).to eq(new_user_session_path) 		   # controller/admin/application_controller.rb
	end

# below are 4 different ways to accomplish signing in as an admin or as a regular user:
	it "cannot be reached by a non-admin person" do 
		# user = create(:user) # user variable is not needed since it is not used anywhere here
		create(:user)
		visit new_user_session_path # to /users/sign_in   page

		fill_in("Email", with: "james1@example.com") # signing in as a regular user
		fill_in("Password", with: "asdfasdf") 		 # needs to match the user factorygirl above
	#	fill_in('user[email]', with: "james1@example.com")   # this way works also
	#	fill_in('user[password]', with: "asdfasdf")

		click_on 'Log in'
		expect(current_path).to eq(root_path) 
		# verifies that Log in worked; it redirected back to root_path because he is not an admin
		# it goes through
		# before_action :authenticate_user!  # checks that a user is signed in
    	# before_filter :authenticate_admin  # checks that the use is an admin

#		expect(page).to have_content("Hello, world!")  
		visit(admin_root_path) # after signing in  user tries to go to admin dashboard
		expect(current_path).to eq(root_path) # gets redirected back to root path because user is non-admin
	#	save_and_open_page
	end

	it "cannot be reached by a non-admin person #2" do 
		user_joe = create(:user)
		login_as(user_joe, user: :user) 
		# this is a helper from devise (need to setup rails_helper.rb to work)
		# this skips all the sign-in statements in method #1 above

		visit(admin_root_path) # after signing in user tries to go to admin dashboard
		expect(current_path).to eq(root_path) # same sequence as above
#		expect(page).to have_content("Hello, world!")
	#	save_and_open_page
	end

	it "cannot be reached by a non-admin person #3" do 
		sign_in(create(:user))
		# this uses a sign_in method created in spec/support/authentication.rb
		# support directory needs to be setup in rails_helper.rb to work

		visit(admin_root_path)
		expect(current_path).to eq(root_path)
#		expect(page).to have_content("Hello, world!")
	end

	it "cannot be reached by a non-admin person #4" do 
		sign_in2(create(:user)) 
		# using another method using spec/support/authentication.rb mehtod #2
		
		visit(admin_root_path)
		expect(current_path).to eq(root_path)
#		expect(page).to have_content("Hello, world!")		
	end

# again here are 4 methods used to check access with an admin user
# these are similar to the 4 examples above with but with an admin user instead of a regular user 
	it "can be reached by an admin person" do 
	#	admin_user = create(:admin_user) # variable admin_user or user is not needed
		create(:admin_user)
	#	visit new_user_session_path # this will work also
		visit(admin_root_path)

		fill_in("Email", with: "admin1@example.com")
		fill_in("Password", with: "asdfasdf")
		click_on 'Log in'

		visit(admin_root_path)		
		expect(current_path).to eq(admin_root_path) 
		# this time it does not get redirected back to root_path becasue the user is an admin user
		expect(page).to have_content("admin1@example.com")
#		save_and_open_page
	end

	it "can be reached by an admin person #2" do 
		user_joe = create(:admin_user)
		login_as(user_joe, user: :user) 
		# this is a helper from devise (need to setup rails_helper.rb to work)

		visit(admin_root_path)
		expect(current_path).to eq(admin_root_path)
		expect(page).to have_content("admin2@example.com")
	#	save_and_open_page
	end

	it "can be reached by an admin person #3" do
		sign_in(create(:admin_user)) # using spec/support/authentication.rb
	
		visit(admin_root_path)
		expect(current_path).to eq(admin_root_path)
		expect(page).to have_content("admin3@example.com")
	#	save_and_open_page
	end 

	it "can be reached by an admin person #4" do
		sign_in2(create(:admin_user)) # using spec/support/authentication.rb
	
		visit(admin_root_path)
		expect(current_path).to eq(admin_root_path)
		expect(page).to have_content("admin4@example.com")
	#	save_and_open_page
	end 

end

