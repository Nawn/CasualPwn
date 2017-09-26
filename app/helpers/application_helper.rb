require "#{Rails.root}/lib/guild_wars_call.rb"
require "#{Rails.root}/lib/discord_bot.rb"

module ApplicationHelper
  def rand_token
    rand(36**8).to_s(36)
  end

  def auth_bot(api_key)
    pull_from_global("bot_shared_api_key") == api_key
  end
  

  def pull_from_global(tag)
    result = GlobalSetting.find_by(tag: tag)
    
    if result.nil?
      return "ERROR: tag #{tag} not found in GlobalSetting"
    else
      return result.content
    end
  end

  def get_guild
    GuildWars::Guild.new(pull_from_global("guild_id"), pull_from_global("guild_leader_api"))
  end

  def get_bot
    Discord::Bot.new(pull_from_global('discord_token'), pull_from_global('discord_client').to_i)
  end
end
