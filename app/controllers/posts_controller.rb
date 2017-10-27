class PostsController < ApplicationController
  include SessionsHelper

  def show
    @post = Post.find(params[:id])
  end

  def new
  	if logged_in?
  		@post = current_user.posts.new
  	else
  		flash[:alert] = "You must be logged in to continue"
  		redirect_to root_path
  	end
  end

  def create
  	if current_user.posts.create(permit_post)
      flash[:notice] = "Success! View your post below: "
    else
      flash[:alert] = "ERROR: Something went wrong. Contact an officer for support."
    end
    
    redirect_to root_path
  end

  private
  def permit_post
  	params.require(:post).permit(:title, :content)
  end
end
