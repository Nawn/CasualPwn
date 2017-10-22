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

end
