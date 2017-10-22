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
	end
end