class PagesController < ApplicationController
  include ApplicationHelper

  def home
	  @posts = Post.order(:created_at => :desc).page(params[:page]).per(5)
	  @announce = Announcement.last
  end

  def apply
  	
  end

  def applicant
  	bot = get_bot

    bot.new_applicant(params[:discord_name], params[:gw_name], params[:note])

    flash[:notice] = "Thank you for applying to the guild! We will reach out to you shortly."
    redirect_to root_path
  end
end
