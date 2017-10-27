Rails.application.routes.draw do

  get 'announcements/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#home'

  post '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  scope '/user' do
    get 'new' => 'users#prep', as: :user_new
    get 'create' => 'users#assign_guild_user', as: :user_create
    patch 'create' => 'users#assign_guild_member', as: :user_assign
    get 'confirm' => 'users#confirm_login', as: :user_confirm
    patch 'confirm/:id' => 'users#confirm_login_save', as: :user_confirm_save
    get 'password' => 'users#password_form'
    patch 'password/:id' => 'users#password_update'
  end

  scope '/posts' do
    get 'new' => 'posts#new', as: :posts
    post 'new' => 'posts#create'
    get 'show/:id' => 'posts#show', as: :posts_show
  end

  get 'apply' => 'pages#apply'

  resources :announcements, :only => [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
