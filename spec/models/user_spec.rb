require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
  	@user = User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "John", last_name: "Doe")
  end
  describe "creation" do
  	it "can be created" do		 
  		expect(@user).to be_valid
  	end
  	it "cannot be creaeted without first_name or last_name" do 
  		@user.first_name = nil
  		@user.last_name = nil
  		expect(@user).to be_invalid
  	end
  end
end
