class GuildEventsController < InheritedResources::Base
  
  def new
  	@guild_event = GuildEvent.new(start_time: Time.current, end_time: Time.current)
  end

  private

    def guild_event_params
      params.require(:guild_event).permit(:start_time_time, :start_time_date, :end_time_time, :end_time_date, :title, :description, :category, :guild_only, :roster_size)
    end
end

