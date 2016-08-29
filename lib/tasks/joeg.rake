# joeg.rake
# this is not part of the app; just a practice on witing tasks

## simple rake tasks
task :greet do # call this by     rake greet
	puts "Hello world!"
end

task :ask => :greet do  # or task ask: :greet do    ## this will call :rgreet first 
	puts "How are you?"
end



## 
	# task :pick_winner do   # this will give an error: uninitialized constant user
							 # this will give an error: uninitialized constant user	
							 # rake does not automatically load env
							 # to load environment add
task :pick_winner => :environment do 
	user = User.all.sample
	puts "The winner is: #{user.full_name}"
end

task :pick_post => :environment do 
	post = Post.all.sample
	puts "The post price is: #{post.rational}"
end


## similar task can be grouped using namespace method
namespace :pick do
	desc "Pick winner description"
	task :winner => :environment do 
		desc "This is the pick winner description." 
		user = User.all.sample
		puts "The winner is: #{user.full_name}"
	end

	desc "Pick post description"
	task :post => :environment do 
		desc "This is the pick winner description." 
		post = Post.all.sample
		puts "The post price is :#{post.rational}"
	end
	
	desc "Pick all description"
	task :all => [:winner, :post]  # rake is OK w/o a block; this is calling 2 dependencies
	desc "This is the pick all description." 
end

## using methods to avoid duplications
namespace :pick2 do
	desc "This is the pick winner description."
	task :winner => :environment do  
		user = pick_class(User)#user = User.all.sample
		puts "The winner is: #{user.full_name}"
	end
	
	desc "This is the pick winner description." 
	task :post => :environment do 
		puts "The post price is :#{pick_class(Post).rational}"
	end

	desc "This is the pick all description." 
	task :all => [:winner, :post]  # rake is OK w/o a block; this is calling 2 dependencies
	
	def pick_class(model_class)
		model_class.all.sample
	end

end









