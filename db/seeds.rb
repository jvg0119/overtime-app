# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(
	first_name: "John", 
	last_name: "Doe",
	email: "john@example.com", 
	password: "asdfasdf", 
	password_confirmation: "asdfasdf", 
	phone: "5555555555" # may need to change later
	)

user2 = User.create(
	first_name: "James", 
	last_name: "Smith",
	email: "james@example.com", 
	password: "asdfasdf", 
	password_confirmation: "asdfasdf",
	phone: "5555555555" 
	)

user_admin = AdminUser.create(
	first_name: "Admin", 
	last_name: "User",
	email: "Admin@example.com", 
	password: "asdfasdf", 
	password_confirmation: "asdfasdf", 
	phone: "5555555555"
	)

users = [user1, user2]

rational1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sodales scelerisque purus, eu porttitor tellus accumsan vitae. Sed ut lobortis elit. Duis tortor neque, hendrerit sed placerat a, condimentum non ante. Aliquam accumsan, massa nec semper accumsan, justo purus tincidunt odio, sit amet dignissim ligula enim dapibus urna." 

rational2 = "Morbi diam lectus, mattis et dui sed, efficitur rutrum lorem. Curabitur volutpat ex eget tortor volutpat commodo. Nullam at viverra dolor, condimentum scelerisque nulla. Aliquam lorem eros, aliquam in tincidunt vel, tempus viverra arcu. Curabitur venenatis scelerisque malesuada."

rationals = [rational1, rational2]

1.upto(20) do |n|
	post = Post.create!(
		date: Date.today,
		rational: "#{n} #{rationals.sample}",
		#user_id: user.id,
		user: users.sample,
		overtime_request: 2.5
		)
end

1.upto(20) do
	audit_log = AuditLog.create!(
		start_date: Date.today - 6.days,
		end_date: nil,
		status: 0,
		user: users.sample
		)
end


puts "*".center(40,"*")
puts
puts "Done seeding".center(40)
puts "Created #{Post.count} posts".center(40)
puts "Created #{User.count} users".center(40)
puts "Created #{AdminUser.count} adminusers".center(40)
puts "Created #{AuditLog.count} auditlogs".center(40)
puts
puts "*".center(40,"*")










