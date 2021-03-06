require 'rails_helper'

describe 'navigate' do 

	# these lets can have mistakes it won't fail if they are not accessed or used	
	let(:user) { create(:user) }
	let(:second_user) { create(:second_user) }
	let(:admin_user) { create(:admin_user) }

#	let(:audit_log) { create(:audit_log, start_date: Date.today) }
#	before(:example) { audit_log }


	let(:user_login) { login_as(user, user: :user) } 
	let(:second_user_login) { login_as(second_user, user: :second_user) }
	let(:admin_user_login) { login_as(admin_user, user: :admin_user) }
	
	let(:post) { create(:post, user: user) } # this post is associated to user
	let(:second_post) { create(:second_post, user: user) } # 

	describe 'index' do 
		it "can be reached successfully and has a title of 'Post'"do 
		# just checking for the index view page; can be deleted as you get further in the testing
			user_login 						
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass

			p post
			visit(posts_path)				
			expect(page.status_code).to eq(200)
			expect(current_path).to eq(posts_path)
			expect(page).to have_content("Posts")
		#	save_and_open_page
		end
		 it "has a list of posts" do # needs to write to DB then read the contents
		#	second_user_login
			user_login 
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass

			p post; second_post # you can stack statements in the same line using ";"
			visit(posts_path)
			expect(page).to have_content("Some rationale")
		#	expect(page).to have_content("Some more rationale")
		#	save_and_open_page
		# this is not a good test because when you create a post using factorygirl it always associates it to a new user. So, currently there are 3 different user_id here.
		# it will pass if I choose the user that logged in which will be the first one
		end
		it "has a scope so that only post creators can see their posts #1" do
		# "has a scope so that only the post's owner can access their posts" 
			user_login
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass
			create(:audit_log, user: second_user) # add to pass undefined method `confirmed!' for nil:NilClass

			#logout(user)
			# admin_user_login
			p post # this is user_id: 1
			second_post # this is user_id: 1
			third_post = create(:post, rational: "Some rationale again", user: second_user) # this is user_id: 2

			visit(posts_path)
			expect(Post.count).to eq(3) # total posts
			expect(user.posts.count).to eq(2)  # post seen by user only
		#	byebug
		#	save_and_open_page
		# this is a bit messy test; not good
		end

		it "has a scope so that only post creators can see their posts #2" do
			user_login
			#second_user_login
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass
			create(:audit_log, user: second_user) # add to pass undefined method `confirmed!' for nil:NilClass

			post1 = create(:post, rational: "first rational content", user: user)
			post2 = create(:post, rational: "second rational content", user: user)
			post3 = create(:post, rational: "third rational content", user: second_user)
			visit(posts_path)

			 expect(page).to_not have_content("third rational content")
			 expect(user.posts.count).to eq(2)  
			 expect(second_user.posts.count).to eq(1)  

		#	save_and_open_page
		end	

	end # describe 'index'

	describe 'new' do 
		it 'has a link from the homepage' do # just looking for the link_to "Add New Entry"
			user_login
			visit(root_path)
			expect(page).to have_link('Request Overtime') # on the navbar; you could visit any page & still work
		#	save_and_open_page 
		end
	end # describe 'add new post'

	describe 'creation' do
		before(:example) do # this visit is used for all creation examples
			user_login
			visit(new_post_path)
		end
		it "has a new form that can be reached" do # just looking for the "new" form
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass
			
			expect(page.status_code).to eq(200)
			expect(current_path).to eq(new_post_path)
		#	save_and_open_page
		end
		it "can be created from the 'new' form page #1" do
		#	fill_in('Date', with: Date.today)  # another way of using fill_in
		#	fill_in('Rational', with: "rationale content")				
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass


			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "new rationale content"	
			fill_in 'post[overtime_request]', with: 2
			# byebug	
			click_on "Create Post" #"Save"
			expect(current_path).to eq(post_path(Post.last)) # this is the re-directed path after saving

			expect(page).to have_content(Date.today) # checking contents
			expect(page).to have_content("new rationale content")
			expect(page).to have_content(/new rationale content/) # works also
			expect(page).to have_content("submitted 2.0")
		#	save_and_open_page
		end 
		it "can be created from the 'new' form page #2" do
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass

			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "new rationale content"	
			fill_in 'post[overtime_request]', with: 2
			# byebug	
		#	click_on "Create Post" #"Save"
		#	expect(current_path).to eq(post_path(Post.last))
			expect { click_on "Create Post" }.to change(Post, :count).by(1)
		end

		it "will have a user associated with it" do 
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass

			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "User Association"
			fill_in 'post[overtime_request]', with: 2.0
			click_on "Create Post" #"Save"
			expect(current_path).to eq(post_path(Post.last)) # last post show page

		# all commented tests work
		#	expect(Post.last.user.first_name).to eq("James")
		#	expect(Post.last.user.posts.last.rational).to eq("User Association") ## the last post's user's last rational
			expect(User.last.posts.last.rational).to eq("User Association") # 
		#	p User.last.posts.last.rational ## the last user's last post's rational attribute
		#	p User.last.first_name
		#	save_and_open_page
		end
	end # describe 'creation'

	describe 'edit' do

		it 'has an edit form that can be reached by clicking edit on index page' do 
			user_login
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass

			p post
			visit(posts_path)
		#	click_link("Edit")  # just a note: click_link("Edit_#{user.id}")
			click_link(p "edit_#{post.id}") # this looks for edit_1 id instead of edit only
			expect(current_path).to eq(edit_post_path(post)) #("/posts/1/edit")
		#	save_and_open_page
		end
		it "can update a post from the edit page by the post's user owner" do
		#	"can be updated by the post's user owner"
			user_login
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass

			post 

			visit(edit_post_path(post)) # visiting the edit form view page
			fill_in('Date', with: Date.today)
			fill_in('Rational', with: "Edited rationale content")
			click_on("Update Post") #'Save')

			expect(current_path).to eq(post_path(post)) # this is the redirect_to path (show page)			
			expect(page).to have_content("Edited rationale content")
		#	save_and_open_page
		end
		it "cannot be updated by a user that is not the post's owner" do 
			user_login 		   ## user see only the his 2 posts; the 3rd post is by second_user	 
		#	admin_user_login   ## admin sees the 3 posts
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass
			create(:audit_log, user: second_user) # add to pass undefined method `confirmed!' for nil:NilClass

			post
			second_post
			post2 = Post.create(date: Date.today, rational: "test rationale", overtime_request: 2.5, user: second_user)

			visit(posts_path)
			expect(current_path).to eq(posts_path)
			visit(edit_post_path(post2)) 

			expect(current_path).to eq(root_path)
		#	expect(page).to have_content("Hello, world!")
		#	save_and_open_page
		end
		it "can be updated by an admin user" do 
			admin_user_login
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass

			post
			visit(edit_post_path(post))

			fill_in('Date', with: Date.today)
			fill_in('Rational', with: "Edited rationale content by admin")
			click_on("Update Post") #'Save')

			expect(current_path).to eq(post_path(post)) # this is the redirect_to path (show page)			
			expect(page).to have_content("Edited rationale content by admin")
		#	save_and_open_page			
		end

	end # describe 'edit'

	describe 'delete' do 
		it 'can remove the selected post' do
			user_login
			create(:audit_log, user: user) # add to pass undefined method `confirmed!' for nil:NilClass
			
			post
			visit(posts_path)

			click_link(p "delete_#{post.id}")
			expect(page).to_not have_content(post)
			expect(current_url).to eq(posts_url)
		#	save_and_open_page
		end 
	end # describe 'delete'

end


