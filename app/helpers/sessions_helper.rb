module SessionsHelper
	def logged_in?
		session[:guild_member_id]
	end
end