# test_spec.rb
require 'rails_helper'

=begin
describe "Test" do 
	before(:example) do 
		@user = create(:user)
		login_as(@user, scope: :user)
	end
	before do
		visit(posts_path)
	end
#	let(:post1) {  }
	it "is going to show the list of posts" do 

		post1 = FactoryGirl.build_stubbed(:post)
		post2 = FactoryGirl.build_stubbed(:second_post) 
		visit(posts_path)
	#	expect(post.date).to eq(Date.today)
	#	expect(post.rational).to eq("first post rational")
		expect(page).to have_content(/first post rational|second post rational/)
#		expect(page).to have_content(/Rationale|content/)

	#	expect(page).to have_content("second post rational")
	#	puts page.body
#		save_and_open_page
	end
end
=end


describe 'navigate' do
  before do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

  	it 'can be reached successfully' do
  		expect(page.status_code).to eq(200)
  	end

  	it 'has a title of Posts' do
  		expect(page).to have_content(/Posts/)
  	end

    it 'has a list of posts' do
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:second_post)
      visit posts_path
      expect(page).to have_content("Some rational")
   # save_and_open_page
    end
  end
 
 

  describe "creation" do 
    it "can be created from new form page" do
      visit(new_post_path)
      fill_in('Date', with: Date.today)
      fill_in('Rational', with: "rationale content")

      #fill_in 'post[date]', with: Date.today  
      #fill_in 'post[rational]', with: "rationale content"  
   #   save_and_open_page    
      click_on "Create Post" #"Save"
      expect(current_path).to eq(post_path(Post.last))

      expect(page).to have_content(Date.today)
      expect(page).to have_content("rationale content")
    # expect(page).to have_content(/rational content/)
    #  save_and_open_page
  end
end


end







