class UsersController < ApplicationController
  include ApplicationHelper
  
  def prep
    new_user_params = get_prep_user_params

    # Index 0 is the Bot API key
    if auth_bot(new_user_params[0])
      begin
        @new_guild_member = GuildMember.create(discord_id: new_user_params[1], discord_nick: new_user_params[2], confirm_token: rand_token)
        render plain: "#{root_url}#{user_create_path[1..-1]}?confirm_token=#{@new_guild_member.confirm_token}"
      rescue ActiveRecord::RecordNotUnique => @e
        render plain: "USER EXISTS"
      end
    else
      render :nothing => true, :status => :forbidden
    end
  end

  def assign_guild_user
    @this_user = GuildMember.find_by(confirm_token: get_confirm_token_param)
  end

  def assign_guild_member
    puts params.inspect
  end

  private
  def get_prep_user_params
    params.require([:bot_key, :discord_id, :discord_nick])
  end

  def get_confirm_token_param
    params.require(:confirm_token)
  end
end
