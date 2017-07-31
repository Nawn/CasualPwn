Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#home'

  scope '/user' do
    get 'new' => 'users#prep', as: :user_new
    get 'create' => 'users#assign_guild_user', as: :user_create
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
