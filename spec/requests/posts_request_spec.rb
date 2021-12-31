# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  include ActionController::RespondWith

  before do
    Faker::UniqueGenerator.clear
    @current_user = User.new(name: 'Test user name', email: 'toto@toto.fr', password: 'password', admin: true)
    @current_user.save

    login
    
    @auth_tokens = get_auth_params_from_login_response_headers(response)
  end

  it 'get all posts from index' do
    get posts_path, headers: @auth_tokens

    expect(response.status).to eq(200)
  end

  it 'create a post' do
    category = FactoryBot.create(:category)
    post = { title: 'test', description: 'petite description', content: 'gnagnagna', categories: [category.id] }
    
    post posts_path, params: { post: post }, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
  end

  it 'not create with wrong parameter' do
    category = FactoryBot.create(:category)
    post = { title: 'test', content: 'gnagnagna', categories: [category.id] }
    
    post posts_path, params: { post: post }, headers: @auth_tokens

    expect(response.status).to eq(412)
  end

  it 'show a post' do
    new_post = FactoryBot.create(:post)

    get post_path(new_post.id), headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
  end

  it 'update a post' do
    new_post = FactoryBot.create(:post)
    new_post.title = "#{new_post.title} changed"
    
    put post_path(new_post.id),
        params: { 
          post: {
            title: new_post.title,
            description: new_post.description,
            content: new_post.content,
            categories: [new_post.categories.collect(&:id).join(',')]
          }
        },
        headers: @auth_tokens
    
    current_post = response_body['data']

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
    expect(current_post['attributes']['title']).to eq new_post.title
  end

  it 'destroy a post' do
    post_to_destroy = FactoryBot.create(:post)

    expect do
      delete post_path(post_to_destroy.id), headers: @auth_tokens
    end.to change(Post, :count).by(-1)
    expect(response.status).to eq(200)
  end
end
