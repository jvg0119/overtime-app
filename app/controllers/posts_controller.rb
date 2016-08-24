class PostsController < ApplicationController

#  before_action :authenticate_user!, only: [:show]

  before_action :set_post, except: [:index, :new, :create]

  def index
   # authorize @posts
   # @posts = Post.all
   # @posts = current_user.posts # this is the quick way to hide other user's posts
   # @posts = policy_scope(Post) # using the pundit scope
   @posts = Post.posts_by(current_user)
  end

  def show
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
  		flash[:notice] = "Post was saved successfully!"
  		redirect_to @post
  	else
  	#	flash[:error] = "Error saving post. Please try again."
  		render :new
  	end
  end

  def edit
    authorize @post # authorize is the method and post is the record
  end               # current_user has access to it

  def update
    authorize @post
    #raise
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated successfully!"
      redirect_to @post 
    else
   #   flash[:error] = "Error updating post. Please try again."
      render :edit
    end
  end

  def destroy
    #raise
    if @post.destroy
      flash[:notice] = "Your post was deleted!"
      redirect_to posts_url
    end
  end  

private

  def post_params
  	params.require(:post).permit(:date, :rational, :status)
  end

  def set_post
  	@post = Post.find(params[:id])
  end

end



