module Discord
	class Bot
		def initialize(api_key, client_id)
			@api_key = api_key
			@client_id = client_id
		end

		def message_user(discord_id, message)
			bot = Discordrb::Bot.new token: @api_key, client_id: @client_id

			bot.run :async

			bot.users[discord_id.to_i].pm(message)
		end

		def announce(title, content)
			bot = Discordrb::Bot.new token: @api_key, client_id: @client_id

			bot.run :async

			bot.send_message(pull_from_global('discord_announcements').to_i, "TITLE: `#{title}`\n```html\n#{ActionController::Base.helpers.strip_tags(content)}\n```")
		end

		def update_permission(discord_id, role_id)
			bot = Discordrb::Bot.new token: @api_key, client_id: @client_id

			bot.run :async
			discord_server = bot.servers[pull_from_global('discord_guild_server').to_i]
			role_to_set = discord_server.role(role_id)
			member_to_update = discord_server.member(discord_id.to_i)

			member_to_update.roles = role_to_set
		end

		def new_applicant(discord_name, gw_name, note)
			bot = Discordrb::Bot.new token: @api_key, client_id: @client_id

			bot.run :async

			bot.send_message(pull_from_global('discord_applications').to_i, "**NEW APPLICANT:**\n\n\nDISCORD NAME:\n`#{discord_name}`\n\nGUILD WARS NAME: \n`#{gw_name}`\n\nNote: \n```\n#{note}\n```")
		end
	end
end