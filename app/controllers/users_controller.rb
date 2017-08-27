require "#{Rails.root}/lib/guild_wars_call.rb"

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
    begin
      @available_users = get_unassigned_users
      @this_user = GuildMember.find_by(confirm_token: get_confirm_token_param)

      if @this_user.registration_progress > 0
        flash[:alert] = "This user has already been assigned a GW2 User. Please contact an Officer to change."
        redirect_to root_path
      end

    rescue RestClient::Forbidden => @f
      flash[:alert] = "Guild Leader API Key Incorrect, please inform an Officer"
      puts "Forbidden (Maybe wrong API Key?): #{@f}"
      redirect_to root_path
    rescue RestClient::NotFound => @n
      flash[:alert] = "Guild Leader API Key Missing, please inform an Officer"
      puts "NotFound (Maybe missing Key?): #{@n}"
      redirect_to root_path
    end
  end

  def assign_guild_member
    # TODO: Get User Rank, and set appropriate Rank Integer & GW2Username
    # Provided by GW2 API
    our_guild = get_guild
    user = get_gw_user
    
    guild_wars_user = our_guild.members.find do |member|
      member['name'] == user[:guild_wars_username]
    end

    rank_int = our_guild.ranks.find do |rank|
      rank['id'] == guild_wars_user['rank']
    end

    # rank_int['order'] is the Integer version of the rank
    @this_user = GuildMember.find_by(discord_id: user[:discord_id])
    @this_user.update({
      guild_wars_username: guild_wars_user['name'],
      guild_rank: rank_int['order'],
      registration_progress: 1
      })

    flash[:notice] = "Success! The New User registration process link will be sent to Discord User"
    redirect_to root_path
  end

  private
  def get_prep_user_params
    params.require([:bot_key, :discord_id, :discord_nick])
  end

  def get_confirm_token_param
    params.require(:confirm_token)
  end

  def get_gw_user
    return params.require(:guild_member).permit(:guild_wars_username, :discord_id, :discord_nick)
  end

  # Returns an array of hashes.
  # Select those guild members which do NOT match any of the website users
  # Because guild_wars_username should be unique, not shared.
  def get_unassigned_users
    current_guild = get_guild

    return current_guild.members.select { |member| 
      !GuildMember.all.any? do |website_user|
        member['name'] == website_user.guild_wars_username
      end
    }
  end
end
