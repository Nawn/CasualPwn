require "#{Rails.root}/lib/discord_bot.rb"

def pull_from_global(tag)
	result = GlobalSetting.find_by(tag: tag)

	if result.nil?
	  return "ERROR: tag #{tag} not found in GlobalSetting"
	else
	  return result.content
	end
end

def get_bot
	Discord::Bot.new(pull_from_global('discord_token'), pull_from_global('discord_client').to_i)
end

ActiveAdmin.register Announcement do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :title, :content

  form do |f|
  	inputs :title

	render partial: 'global/blog_post_editor', locals: {target: '#announcement_content.tinymce'}
	input :content, :input_html => {:class => 'tinymce'}
	actions
  end

  before_create do |the_announcement|
  	bot = get_bot

  	bot.announce(the_announcement.title, the_announcement.content)
  end
end