class Post < ActiveRecord::Base

	enum status: { submitted: 0, approved: 1, rejected: 2 }

	belongs_to :user

	validates :date, :rational, presence: true
#	validates :rational, presence: true

end

# status: 
# submitted
# approved
# rejected

