
# this is using inheritance

FactoryGirl.define do 
	factory :first_post, class: Post do
		date Date.today
		rational "Some rationale"
		association :user  # user  is OK

			factory :second_post do # inherits from first_posts	
			date Date.yesterday
			rational "Some more rationale"
		#	association :user    # no need to include here because it inherits from first_post
		end
	end
end




=begin
# this is using 2 separate factories

FactoryGirl.define do
	factory :first_post, class: Post do 
		date Date.today
		rational "Some rationale"
		user
	end
	factory :second_post, class: Post do 
		date Date.yesterday
		rational "Some more rationale"
		user
	end
end

=end











