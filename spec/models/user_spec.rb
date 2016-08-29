require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }
  describe "creation" do
  	it "can be created with valid first_name, last_name, and phone" do		 
  		expect(user).to be_valid
  	end
    it "cannot be created without a first_name" do 
      user.first_name = ''
      #expect(user).to be_invalid ## this will pass w/ a blank first_name; not good
      user.valid?
      expect(user.errors[:first_name]).to eq(["can't be blank"])
    end
    it "cannot be created without a last_name" do 
      user.last_name = nil
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end
    it "cannot be created without a phone" do 
      user.phone = nil
      user.valid?
      expect(user.errors[:phone]).to include("can't be blank")
    end
    it "cannot be created if phone number has '-' a dash or dashes" do 
      user.phone = "555-555-5555"
      user.valid?
      expect(user.errors[:phone]).to include("bad format")
    end
    it "cannot be created if phone number has ' ' a space or spaces" do 
      user.phone = "555 555 5555"
      user.valid?
      expect(user.errors[:phone]).to include("bad format")
    end
    it "cannot be created if phone number has a letter or letters" do 
      user.phone = "a555555555"
      user.valid?
      expect(user.errors[:phone]).to include("bad format")
    end
  end

  describe "full_name method" do  
    it "combines the first and last name" do
      user
      expect(user.full_name).to eq("Smith, James")
    end
  end  
end
