class PostsController < ApplicationController

#  before_action :authenticate_user!, only: [:show]

  before_action :set_post, except: [:index, :new, :create]

  def index
    @posts = Post.all
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
  		flash[:success] = "Post was saved successfully!"
  		redirect_to @post
  	else
  	#	flash[:error] = "Error saving post. Please try again."
  		render :new
  	end
  end

  def edit
  end

  def update
    #raise
    if @post.update_attributes(post_params)
      flash[:success] = "Post was updated successfully!"
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
  	params.require(:post).permit(:date, :rational)
  end

  def set_post
  	@post = Post.find(params[:id])
  end

end



