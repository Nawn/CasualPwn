class GuildEventsController < InheritedResources::Base
  include SessionsHelper
  
  def new
  	if logged_in? 
  		@guild_event = GuildEvent.new(start_time: Time.current, end_time: Time.current, roster_size: 0)
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

  def create

    @this_event = GuildEvent.new(guild_event_params)
    @this_event.guild_member = current_user
    @this_event.roster = [current_user.id]

    if @this_event.save
      flash[:notice] = "Success! Your event has been created!"
      redirect_to @this_event
    else  
      flash[:alert] = "Hm, something went wrong."
      redirect_to guild_events
    end
    

  end

  private

    def guild_event_params
      params.require(:guild_event).permit(:start_time_time, :start_time_date, :end_time_time, :end_time_date, :title, :description, :category, :guild_only, :roster_size)
    end
end

