class GuildEventsController < InheritedResources::Base

  private

    def guild_event_params
      params.require(:guild_event).permit(:start_time, :end_time, :title, :description, :category, :guild_only, :roster_size)
    end
end

