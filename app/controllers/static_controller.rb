class StaticController < ApplicationController
#  before_action :authenticate_user!

def homepage
	@pending_approvals = Post.where(status: 'submitted')
#	@posts = Post.all
end

end