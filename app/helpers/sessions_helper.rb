module SessionsHelper
	def logged_in?
		session[:guild_member_id]
	end

	def current_user
		GuildMember.find(session[:guild_member_id])
	end
end