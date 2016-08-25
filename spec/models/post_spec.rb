require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build(:post) }#, overtime_request: 3.5) }

  describe "creation" do 
  	it "can be created" do
  		expect(post).to be_valid
  	end
    it "cannot be created without a date, rationale, and overtime request" do 
      post.date = nil
      post.rational = nil
      post.overtime_request = nil
      expect(post).to be_invalid
    end
        
    it "can be created with a valid date, rationale, and overtime request" do 
      post
      expect(post).to be_valid
    end
    it "cannot be created without a date" do 
      post.date = nil
      post.valid?
      expect(post.errors[:date]).to include("can't be blank") 
    end
    it "cannot be created without a rationale" do 
      post.rational = nil
      post.valid?
      expect(post.errors[:rational]).to include("can't be blank") 
    end
    it "cannot be created with an overtime_request 0.0 or less #1" do 
      post.overtime_request = 0.0
      post.valid?
      #byebug
      expect(post.errors[:overtime_request]).to include("must be greater than 0.0") 
    end
    it "cannot be created with an overtime_request 0.0 or less #2" do 
      post.overtime_request = 0.0
      expect(post).to be_invalid
    end    
  end

end









