class PostsController < ApplicationController
  include SessionsHelper

  def new
  	if logged_in?
  		@post = current_user.posts.new
  	else
  		flash[:alert] = "You must be logged in to continue"
  		redirect_to root_path
  	end
  end
end
