# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth'

  scope constraints: { format: 'json' } do
    resources :categories
    resources :posts
    resources :users
    get '/articles/:category_id', to: 'articles#index'
  end
end
