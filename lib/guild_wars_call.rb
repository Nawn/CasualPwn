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
		
		# Returns an Array of Hashes containing name, rank, joined
		def members
			current_path = "members"
			response = RestClient.get("#{@guild_wars_base}#{@guild_path}#{current_path}#{@access_token}")

			# It's an Array of Hashes
			JSON.parse(response.body)
		end
	end
end