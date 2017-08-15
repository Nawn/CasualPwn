class UsersController < ApplicationController
  include ApplicationHelper
  
  def prep
    new_user_params = get_prep_user_params

    # Index 0 is the Bot API key
    if auth_bot(new_user_params[0])
      begin
        @new_guild_member = GuildMember.create(discord_id: new_user_params[1], discord_nick: new_user_params[2], confirm_token: rand_token, registration_progress: 0)
        render plain: "#{root_url}#{user_create_path[1..-1]}?confirm_token=#{@new_guild_member.confirm_token}"
      rescue ActiveRecord::RecordNotUnique => @e
        # Continue onto the next step, after checking registration progress
        @existing_guild_member = GuildMember.find_by(discord_id: new_user_params[1])

        if @existing_guild_member.registration_progress == 0
          render plain: "#{root_url}#{user_create_path[1..-1]}?confirm_token=#{@existing_guild_member.confirm_token}"
        elsif @existing_guild_member.registration_progress == 1
          # At this point, the Guild wars 2 Account has already been applied, so we should send out a message to the user
          # To create a username, and a password

          
        end
        
        render plain: "USER EXISTS"
      end
    else
      render :nothing => true, :status => :forbidden
    end
  end

  def assign_guild_user
    # TODO: Program call to GW2 API, then compare against all Users to check which
    #       Have not been assigned, and display those as an option for Dropdowns
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
