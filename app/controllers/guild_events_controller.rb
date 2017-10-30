class GuildEventsController < InheritedResources::Base
  include SessionsHelper
  
  def new
  	if logged_in? 
  		@guild_event = GuildEvent.new(start_time: Time.current, end_time: Time.current)
  	else
  		flash[:alert] = "You must be logged in to create a new event"
  		redirect_to guild_events_path
  	end
  end

  def index
    @ongoing = GuildEvent.where('start_time < ?', Time.zone.now).where('end_time > ?', Time.zone.now)
    @upcoming = GuildEvent.where('start_time > ?', Time.zone.now)
    super
  end

  private

    def guild_event_params
      params.require(:guild_event).permit(:start_time_time, :start_time_date, :end_time_time, :end_time_date, :title, :description, :category, :guild_only, :roster_size)
    end
end

