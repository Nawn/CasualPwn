module GuildEventsHelper
	def event_link(event, member)
		if event.roster.include? member.id
			link_to "Dropout", guild_event_leave_path(event)
		else
			link_to "Signup", guild_event_join_path(event)
		end
	end
end
