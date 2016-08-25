
FactoryGirl.define do 
#	factory :post, class: Post do
	factory :post do
		date Date.today
		rational "Some rationale"
	    association :user   # user  is OK
	    overtime_request 3.5
	end	
	factory :second_post, class: Post do 	
		date Date.yesterday
		rational "Some more rationale"
	#	second_user
		association :user
		overtime_request 0.5		
	end

	# factory :third_post, class: Post do
	# 	date Date.yesterday
	# 	rational "Some even more rationale"
	# 	overtime_request 0.5
	# #	user
	# #	second_user  # this does not work; just create a local user on the test
	# end

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




