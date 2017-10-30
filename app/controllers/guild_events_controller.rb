class GuildEventsController < InheritedResources::Base
  include SessionsHelper
  
  def new
  	if logged_in? 
  		@guild_event = GuildEvent.new(start_time: Time.current, end_time: Time.current, roster_size: 0, notice: 0)
  	else
  		flash[:alert] = "You must be logged in to create a new event"
  		redirect_to guild_events_path
  	end
  end

  def index
    if logged_in?
      @ongoing = GuildEvent.where('start_time < ?', Time.zone.now).where('end_time > ?', Time.zone.now).order(end_time: :asc)
      @upcoming = GuildEvent.where('start_time > ?', Time.zone.now).order(start_time: :asc).page(params[:page]).per(5)
    else
      @ongoing = GuildEvent.where('start_time < ?', Time.zone.now).where('end_time > ?', Time.zone.now).where(guild_only: false).order(end_time: :asc)
      @upcoming = GuildEvent.where('start_time > ?', Time.zone.now).order(start_time: :asc).where(guild_only: false).page(params[:page]).per(5)
    end

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

  def join

    @this_event = GuildEvent.find(params[:id])

    if @this_event
      if logged_in?
        if @this_event.roster.include? current_user.id
          flash[:notice] = "You're already signed up!"
        else
          if @this_event.spaces_available == 0
            flash[:alert] = "There are no spaces available"
          else
            @this_event.roster << current_user.id
            @this_event.save(validate: false)
            flash[:notice] = "Success! You have signed up."
          end
        end

        redirect_to guild_events_path
      else
        flash[:alert] = "You must be signed in to join an event"
        redirect_to guild_events_path
      end
    else
      flash[:alert] = "Event does not exist"
      redirect_to guild_events_path
    end
  end

  def leave

    @this_event = GuildEvent.find(params[:id])

    if @this_event
      if logged_in?
        if @this_event.roster.include? current_user.id
          @this_event.roster = @this_event.roster - [current_user.id]
          @this_event.save(validate: false)
          flash[:notice] = "Success! You have dropped out of this event."
        else
          flash[:alert] = "You weren't signed up for this event"
        end

        redirect_to guild_events_path
      else
        flash[:alert] = "You must be signed in to drop out of an event"
        redirect_to guild_events_path
      end
    else
      flash[:alert] = "Event does not exist"
      redirect_to guild_events_path
    end

  end

  private

    def guild_event_params
      params.require(:guild_event).permit(:start_time_time, :start_time_date, :end_time_time, :end_time_date, :title, :description, :category, :guild_only, :roster_size)
    end
end

