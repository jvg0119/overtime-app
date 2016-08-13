require 'rails_helper'

RSpec.describe Post, type: :model do
  before do 
  	@post = Post.create(date: Date.today, rational: "Anything") 
  end
  describe "creation" do 
  	it "can be created" do
  		expect(@post).to be_valid
  	end
  	it "cannot be created without a date and rational" do 
  	 	@post.date = nil
  	 	@post.rational = nil
  	 	expect(@post).to be_invalid
  	end
  end

end
