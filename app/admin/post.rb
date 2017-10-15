ActiveAdmin.register Post do
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
  permit_params :title, :content, :guild_only

  index do |post|
    column :title
    column :content do |the_content|
      strip_tags(the_content.content).truncate(150)
    end

    column :guild_only
    actions
  end

  form title: 'Post' do |f|
  	inputs 'Post Information' do 
  		input :title
  		input :guild_only
  	end

  	inputs "Post Content" do
      render partial: 'blog_post_editor', locals: {target: '#post_content.tinymce'}
  		input :content, :input_html => {:class => 'tinymce'}
  	end
  	actions
  end
end
