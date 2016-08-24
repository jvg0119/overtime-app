
FactoryGirl.define do 
#	factory :post, class: Post do
	factory :post do
		date Date.today
		rational "Some rationale"
	    association :user   # user  is OK
	end	
	factory :second_post, class: Post do 	
		date Date.yesterday
		rational "Some more rationale"
		user
	#	association second_user
	end

	factory :third_user, class: Post do
		date Date.yesterday
		rational "Some more rationale"
	#	user
	#	second_user  # this does not work; just create a local user on the test
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




