class Post < ActiveRecord::Base

	belongs_to :user

	validates :date, :rational, presence: true
#	validates :rational, presence: true

end
