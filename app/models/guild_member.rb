require "#{Rails.root}/lib/guild_wars_call.rb"

def pull_from_global(tag)
	result = GlobalSetting.find_by(tag: tag)

	if result.nil?
	  return "ERROR: tag #{tag} not found in GlobalSetting"
	else
	  return result.content
	end
end

class GuildMember < ApplicationRecord
	include ApplicationHelper

	has_secure_password :validations => false
	has_many :posts
	has_many :guild_events

	def self.update_ranks
		our_guild = GuildWars::Guild.new(pull_from_global("guild_id"), pull_from_global("guild_leader_api"))
		our_bot = Discord::Bot.new(pull_from_global('discord_token'), pull_from_global('discord_client').to_i)

		rank_reference = Hash.new

		# Cross reference the name of the rank with the actual Integer
		# need rank_reference to store that data
		our_guild.ranks.each do |rank|
			rank_reference[rank['id']] = rank['order']						
		end

		# Cross Reference for Rank to Discord Role ID (To set Role in Discord)
		rank_to_discord = Hash.new
		rank_to_discord[1] = 337060888068751363
		rank_to_discord[2] = 337061298233933824
		rank_to_discord[3] = 337061672940339201
		rank_to_discord[4] = 337062083654844418
		rank_to_discord[5] = 337062826801758210

		gw2_users = our_guild.members

		GuildMember.all.each do |site_member|
			# Account must be complete to have Rank updated 
			next unless site_member.registration_progress > 1
			
			# Find the appropriate guild wars User,
			# Grab the rank, and run it through my reference to find the Rank Order Integer
			my_gw2_user = gw2_users.find {|gw2_user_hash| gw2_user_hash['name'] == site_member.guild_wars_username }
			my_gw2_rank = my_gw2_user['rank']

			my_rank_int = rank_reference[my_gw2_rank]

			site_member.update!(guild_rank: my_rank_int.to_i)

			our_bot.update_permission(site_member.discord_id, rank_to_discord[my_rank_int])
		end
	end
end
