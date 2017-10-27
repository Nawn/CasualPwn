class PagesController < ApplicationController

  def home
	  @posts = Post.order(:created_at => :desc).page(params[:page]).per(5)
	  @announce = Announcement.last
  end

  def apply
  	
  end
end
