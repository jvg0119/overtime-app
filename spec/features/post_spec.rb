require 'rails_helper'

describe 'navigate' do 
	before(:example) do
		user_joe = create(:user)
		login_as(user_joe, user: :user)
	end
	describe 'index' do 
		let(:post1) { create(:first_post) }
		let(:post2) { create(:second_post) }
		it 'can be reached successfully' do 
			visit(posts_path)
			expect(page.status_code).to eq(200)
		end
		it "has a title of post" do # needs to be logged in
			visit(posts_path)
			expect(page).to have_content("Posts") 
		#	save_and_open_page
		end
		 it "has a list of posts" do # need to be logged in
			post1; post2
			visit(posts_path)
			expect(page).to have_content("Some rationale") 
			expect(page).to have_content("Some more rationale")
		#	save_and_open_page
		end
	end
	describe "creation" do  # needs to be logged in
		before(:example) do
			visit(new_post_path)
		end
		it "has a new form that can be reached" do 
			expect(page.status_code).to eq(200)
		#	save_and_open_page
		end
		it "can be created from new form page" do
		#	fill_in('Date', with: Date.today)
		#	fill_in('Rational', with: "rationale content")				

			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "rationale content"	
		
			click_on "Save"
			expect(current_path).to eq(post_path(Post.last))

			expect(page).to have_content(Date.today)
			expect(page).to have_content("rationale content")
		#	expect(page).to have_content(/rational content/)
		#	save_and_open_page
		end 
		it "will have a user associated with it" do 
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rational]', with: "User Association"
			click_on "Save"
			expect(current_path).to eq(post_path(Post.last))

		#	expect(Post.last.user.first_name).to eq("James")
		#	expect(Post.last.user.posts.last.rational).to eq("User Association")
			expect(User.last.posts.last.rational).to eq("User Association")
		#	p User.last.posts.last.rational
		#	p User.last.first_name
		end
	end


end


