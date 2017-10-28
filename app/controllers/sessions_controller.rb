class SessionsController < ApplicationController

	def destroy
		if session[:guild_member_id]
			session[:guild_member_id] = nil
			flash[:notice] = "You have successfully logged out"
		end

		redirect_to root_path
	end

	def new
		# Grab the user based on the username entered.
		user_login = params.permit(:username, :password)
		user_login[:username] = user_login[:username].downcase
		
		@this_user = GuildMember.find_by(username: user_login[:username])

		# Check if the user even exists
		if @this_user
			puts "\n\nTHE USER EXISTS\n\n"

			# Then try to get the user using Authenticate
			@logged_in = @this_user.authenticate(user_login[:password])

			if @logged_in
				puts "\n\n LOGGED IN RETURNED SOMETHING\n\n"
				session[:guild_member_id] = @logged_in.id
				flash[:notice] = "Welcome, #{@logged_in.username.capitalize}"
				redirect_to root_path
			else
				puts "\n\n LOGGED IN RETURNED NOTHING\n\n"
				flash[:alert] = "Username/Password combination error"
				redirect_to root_path				
			end
		else
			puts "\n\nTHE USER DOESN'T EXIST\n\n"
			flash[:alert] = "Username/Password combination error"
			redirect_to root_path
		end
	end
end
