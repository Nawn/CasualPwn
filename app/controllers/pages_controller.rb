class PagesController < ApplicationController
  include SessionsHelper

  def home
	  @posts = Post.order(:created_at => :desc)
  end
end
