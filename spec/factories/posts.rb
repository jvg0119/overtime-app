


FactoryGirl.define do 
#	factory :first_post, class: Post do  # replacing this
#	factory :post, class: Post do
	factory :post do
		date Date.today
		rational "Some rationale"
	    association :user   # user  is OK
	end	
	factory :second_post, class: Post do # inherits from factory :post	
		date Date.yesterday
		rational "Some more rationale"
		user
	#	association second_user
	end
end


=begin

# this is using inheritance
# this also work
FactoryGirl.define do 
	factory :post do
		date Date.today
		rational "Some rationale"
	    association :user   # user  is OK
	
		factory :second_post, class: Post do # inherits from factory :post	
			date Date.yesterday
			rational "Some more rationale"
		end
	end
end


=end




