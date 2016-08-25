# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(email: "john@example.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "John", last_name: "Doe")
user2 = User.create(email: "james@example.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "James", last_name: "Smith")
user_admin = AdminUser.create(email: "Admin@example.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Admin", last_name: "User")

users = [user1, user2]

1.upto(100) do |n|
	post = Post.create!(
		date: Date.today,
		rational: "#{n} rational content",
		#user_id: user.id,
		user: users.sample,
		overtime_request: 2.5
		)
end


puts "*".center(40,"*")
puts
puts "Done seeding".center(40)
puts "Created #{Post.count} posts".center(40)
puts "Created #{User.count} users".center(40)
puts "Created #{AdminUser.count} adminusers".center(40)
puts
puts "*".center(40,"*")










