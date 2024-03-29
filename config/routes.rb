# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth'

  scope constraints: { format: 'json' } do
    resources :categories
    resources :posts
    resources :users

    # publish a post
    post '/post/publish/:id', to: 'posts#publish', as: :publish_post

    # Visitor's articles and categories
    get '/articles/category/:category_id', to: 'articles#from_category'
    get '/article/:article_id', to: 'articles#show'
    get '/articles/categories', to: 'articles#categories'
    get '/category/:category_id', to: 'articles#category'

    # Send email
    post '/contacts/send', to: 'contacts#create'
  end
end
