class Post < ActiveRecord::Base

	enum status: { submitted: 0, approved: 1, rejected: 2 }

	belongs_to :user

	validates :date, :rational, presence: true
	validates :overtime_request, numericality: { greater_than: 0.0 }
#	validates :rational, presence: true

	scope :posts_by, -> (user) { Post.where(user: user) }



end

# status: 
# submitted
# approved
# rejected

