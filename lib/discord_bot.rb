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
	end
end