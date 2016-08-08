class Post < ActiveRecord::Base

	validates :date, :rational, presence: true
#	validates :rational, presence: true

end
