class PagesController < ApplicationController

  def home
	  @posts = Post.order(:created_at => :desc).page(params[:page]).per(5)
  end
end
