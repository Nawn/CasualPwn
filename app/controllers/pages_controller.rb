class PagesController < ApplicationController
  include SessionsHelper

  def home
	  @posts = Post.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 5)
  end
end
