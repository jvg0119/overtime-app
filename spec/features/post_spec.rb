require 'rails_helper'

describe 'navigate' do 
	before(:example) do # wraps all the examples in "navigate" because you cannot do anything w/o being logged in
		user_joe = create(:user)
		login_as(user_joe, user: :user) # this is a helper from devise (need to setup rails_helper.rb to work)
	end
	describe 'index' do 
		let(:post1) { create(:post) } # used for index only
		let(:post2) { create(:second_post) }
		it 'can be reached successfully' do # just checking for the index view page
			visit(posts_path)				# does not use let(:post1)
			expect(page.status_code).to eq(200)
		end
		it "has a title of post" do # checking contents in index view page
			visit(posts_path) 		# does not use let(:post1)
			expect(page).to have_content("Posts") 
		#	save_and_open_page
		end
		 it "has a list of posts" do # needs to write to DB then read the contents
			post1; post2 # you can stack statements in the same line using ";"
			visit(posts_path)
			expect(page).to have_content("Some rationale")
			expect(page).to have_content("Some more rationale")
		#	save_and_open_page
		end
	end # describe 'index'

	describe 'new' do 
		it 'has a link from the homepage' do # just looking for the link_to "Add New Entry"
			visit(root_path)
			expect(page).to have_link('Add New Entry') # on the navbar; you could visit any page & still work
		#	save_and_open_page 
		end
	end # describe 'add new post'

	describe 'creation' do
		before(:example) do # this visit is used for all creation examples
			visit(new_post_path)
		end
		it "has a new form that can be reached" do # just looking for the "new" form
			expect(page.status_code).to eq(200)
		#	save_and_open_page
		end
		it "can be created from the 'new' form page" do
		#	fill_in('Date', with: Date.today)  # another way of using fill_in
		#	fill_in('Rational', with: "rationale content")				

			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "rationale content"	
		
			click_on "Create Post" #"Save"
			expect(current_path).to eq(post_path(Post.last)) # this is the re-directed path after saving

			expect(page).to have_content(Date.today) # checking contents
			expect(page).to have_content("rationale content")
			expect(page).to have_content(/rationale content/) # works
		#	save_and_open_page
		end 
		it "will have a user associated with it" do 
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "User Association"
		
			click_on "Create Post" #"Save"
		
			expect(current_path).to eq(post_path(Post.last))

		#	expect(Post.last.user.first_name).to eq("James")
		#	expect(Post.last.user.posts.last.rational).to eq("User Association")
			expect(User.last.posts.last.rational).to eq("User Association")
		#	p User.last.posts.last.rational
		#	p User.last.first_name
		end
	end # describe 'creation'

	describe 'edit' do
		let(:post) { create(:post) }
		# before(:example) do 
		# 	@post = create(:first_post)
		# end 
		it 'has an edit form that can be reached by clicking edit on index page' do 
		#	post = create(:post)
			post
			visit(posts_path)
			click_link("Edit") # there is another edit on the page (Account>Edit Detail)
		#	save_and_open_page
			expect(current_path).to eq(edit_post_path(post)) # this is a better test than 200
			expect(page.status_code).to eq(200)
		end
		it 'can update a post from the edit page' do
			visit(edit_post_path(post)) # visiting the edit form view page
			fill_in('Date', with: Date.today)
			fill_in('Rational', with: "Edited rationale content")
			click_on("Update Post") #'Save')

			expect(current_path).to eq(post_path(post)) # this is the redirect_to path (show page)			
			expect(page).to have_content("Edited rationale content")
		#	save_and_open_page
		end
	end # describe 'edit'

	describe 'delete' do 
		it 'can remove the selected post' do
			post = create(:post)
			visit(posts_path)
			click_link('Delete')
			expect(page).to_not have_content(post)
			expect(current_url).to eq(posts_url)
		#	save_and_open_page
		end 
	end # describe 'delete'

end


