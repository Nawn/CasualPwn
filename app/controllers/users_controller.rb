class UsersController < ApplicationController
  include ApplicationHelper
  
  def prep
    new_user_params = get_prep_user_params

    if pull_from_global("bot_shared_api_key") == new_user_params[0]
      @new_guild_member = GuildMember.create(discord_id: new_user_params[1], discord_nick: new_user_params[2], confirm_token: rand(36**8).to_s(36))
    else
      render :nothing => true, :status => :forbidden
    end
  end

  private
  def get_prep_user_params
    params.require([:bot_key, :discord_id, :discord_nick])
  end
end
