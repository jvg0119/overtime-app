FactoryGirl.define do 
	factory :user do #  , class: User do 
		first_name "James"
		last_name "Smith"
		sequence(:email) { |n| "#{first_name}#{n}@example.com" }
		password "asdfasdf"
		password_confirmation "asdfasdf"
	end

		factory :admin_user, class: AdminUser do 
			first_name "Admin"
			last_name "User"
			sequence(:email) { |n| "#{first_name}#{n}@example.com" }
			password "asdfasdf"
			password_confirmation "asdfasdf"
		end 
end






=begin


FactoryGirl.define do
	sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    first_name 'Jon'
    last_name 'Snow'
    email { generate :email }
    password "asdfasdf"
    password_confirmation "asdfasdf"
  end

  factory :admin_user, class: "AdminUser" do
    first_name 'Admin'
    last_name 'User'
    email { generate :email }
    password "asdfasdf"
    password_confirmation "asdfasdf"
  end
end


=end



=begin

FactoryGirl.define do
	sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    first_name 'Jon'
    last_name 'Snow'
    email { generate :email }
    password "asdfasdf"
    password_confirmation "asdfasdf"
  end

  factory :admin_user, class: "AdminUser" do
    first_name 'Admin'
    last_name 'User'
    email { generate :email }
    password "asdfasdf"
    password_confirmation "asdfasdf"
  end
end


=end






