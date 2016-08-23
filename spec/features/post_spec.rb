require 'rails_helper'

describe 'navigate' do 

	# these lets can have mistakes it won't fail if they are not accessed or used	
	let(:user) { create(:user) }
	let(:second_user) { create(:second_user) }
	let(:admin_user) { create(:admin_user) }

	let(:user_login) { login_as(user, user: :user) } 
	let(:second_user_login) { login_as(create(:second_user), user: :user) }
	let(:admin_user_login) { login_as(create(:admin_user), user: :user) }
	
	let(:post) { create(:post, user: user) } # this post is associated to user
	let(:second_post) { create(:second_post, user: second_user) } # this post is associated to second_user

	describe 'index' do 
		it "can be reached successfully and has a title of 'Post'"do # just checking for the index view page
			user_login 						
			post
			visit(posts_path)				
			expect(page.status_code).to eq(200)
			expect(current_path).to eq(posts_path)
			expect(page).to have_content("Posts")
		#	save_and_open_page
		end
		 it "has a list of posts" do # needs to write to DB then read the contents
			second_user_login
			post; second_post # you can stack statements in the same line using ";"
			visit(posts_path)
			expect(page).to have_content("Some rationale")
			expect(page).to have_content("Some more rationale")
		#	save_and_open_page
		end
	end # describe 'index'

	describe 'new' do 
		it 'has a link from the homepage' do # just looking for the link_to "Add New Entry"
			user_login
			visit(root_path)
			expect(page).to have_link('Add New Entry') # on the navbar; you could visit any page & still work
		#	save_and_open_page 
		end
	end # describe 'add new post'

	describe 'creation' do
		before(:example) do # this visit is used for all creation examples
			user_login
			visit(new_post_path)
		end
		it "has a new form that can be reached" do # just looking for the "new" form
			expect(page.status_code).to eq(200)
			expect(current_path).to eq(new_post_path)
		#	save_and_open_page
		end
		it "can be created from the 'new' form page" do
		#	fill_in('Date', with: Date.today)  # another way of using fill_in
		#	fill_in('Rational', with: "rationale content")				

			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "new rationale content"	
		
			click_on "Create Post" #"Save"
			expect(current_path).to eq(post_path(Post.last)) # this is the re-directed path after saving

			expect(page).to have_content(Date.today) # checking contents
			expect(page).to have_content("new rationale content")
			expect(page).to have_content(/new rationale content/) # works also
		#	save_and_open_page
		end 
		it "will have a user associated with it" do 
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "User Association"
	
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
			post
			visit(posts_path)
			click_link("Edit")  # just a note: click_link("Edit_#{user.id}")
			expect(current_path).to eq(edit_post_path(post)) #("/posts/1/edit")
		end
		it "can update a post from the edit page by the post's user owner" do
		#	"can be updated by the post's user owner"
			user_login
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
			user_login
			second_post
			visit(edit_post_path(second_post))

			expect(current_path).to eq(root_path)
			expect(page).to have_content("Hello, world!")
		#	save_and_open_page
		end
		it "can be updated by an admin user" do 
			admin_user_login
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
			post
			visit(posts_path)

			click_link('Delete')
			expect(page).to_not have_content(post)
			expect(current_url).to eq(posts_url)
		#	save_and_open_page
		end 
	end # describe 'delete'

end


