require 'rails_helper'

describe 'navigate' do 
	before do 
		@user = User.create(email: "john@example.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "John", last_name: "Doe")
		login_as(@user, :scope => :user)  
	end
	describe 'index' do 
		before do 	
			post1 = Post.create(date: Date.today, rational: "post 1", user: @user)
			post2 = Post.create(date: Date.today, rational: "post 2", user: @user)
			visit(posts_path)
		end

		it 'can be reached successfully' do 
		#	visit(posts_path)
			expect(page.status_code).to eq(200)
		end
		it "has a title of post" do
		#	visit(posts_path)
			expect(page).to have_content(/Posts/) # change from "Posts" to "Log in" to clear error
		end 									  # because of the devise authentication
												  # adding login now put "Posts" back to pass	
		it "has a list of posts" do 
			expect(page).to have_content(/post 1|post 2/) # add index view content
		end
	end
	describe "creation" do 
		before do
			visit(new_post_path)
		end
		it "has a new form that can be reached" do 
		#	visit(new_post_path)
			expect(page.status_code).to eq(200)
			expect(page).to have_content(/New Post/)
		end
		it "can be created from new form page" do
		#	visit(new_post_path)
		#	fill_in('Date', with: Date.today)
			fill_in 'post[date]', with: Date.today
		#	fill_in('Rational', with: "rational content")			
			fill_in 'post[rational]', with: "rational content"	
		#	save_and_open_page		
			click_on "Save"
			expect(page).to have_content(Date.today)
			expect(page).to have_content("rational content")
		#	expect(page).to have_content(/rational content/)
		end 
		it "will have a user associated with it" do 
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "User Association"
			click_on "Save"
		#	expect(Post.last.user.first_name).to eq("John")
		#	expect(Post.last.user.posts.last.rational).to eq("User Association")
			expect(User.last.posts.last.rational).to eq("User Association")
		#	p User.last.posts.last.rational
		#	p User.last.first_name
		end
	end
end





