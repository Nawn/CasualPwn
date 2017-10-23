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

	def self.update_ranks
		our_guild = GuildWars::Guild.new(pull_from_global("guild_id"), pull_from_global("guild_leader_api"))

		our_guild.members
	end
end
