module GuildWars
	class ApiCall
		def initialize(api_key)
			@api_key = api_key
			@access_token = "?access_token=#{@api_key}"
			@guild_wars_base = "https://api.guildwars2.com/v2/"
		end
	end


	class Guild < ApiCall
		def initialize(guild_id, api_key)
			super(api_key)
			@guild_id = guild_id
			@guild_path = "guild/#{@guild_id}/"
		end

		def ranks
			current_path = "ranks"
			guild_call(current_path)
		end
		
		# Returns an Array of Hashes containing name, rank, joined
		def members
			current_path = "members"
			guild_call(current_path)
		end

		private
		def guild_call(path)
			response = RestClient.get("#{@guild_wars_base}#{@guild_path}#{path}#{@access_token}")

			JSON.parse(response.body)
		end
	end
end