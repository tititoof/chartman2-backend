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
    category = create(:category)
    post = { title: 'test', description: 'petite description', content: 'gnagnagna', categories: [category.id] }

    post posts_path, params: { post: }, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
  end

  it 'not create with wrong parameter' do
    category = create(:category)
    post = { title: 'test', content: 'gnagnagna', categories: [category.id] }

    post posts_path, params: { post: }, headers: @auth_tokens

    expect(response.status).to eq(412)
  end

  it 'show a post' do
    new_post = create(:post)

    get post_path(new_post.id), headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
  end

  it 'not show a wrong post' do
    get post_path(0), headers: @auth_tokens

    expect(response.status).to eq(412)
  end

  it 'update a post' do
    new_post = create(:post)
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

  it 'update a post with wrong parameters' do
    new_post = create(:post)

    put post_path(new_post.id),
        params: {
          post: {
            title: new_post.title,
          }
        },
        headers: @auth_tokens

    expect(response.status).to eq(412)
  end

  it 'not update a wrong post' do
    new_category = create(:category)
    put post_path(0),
        params: {
          post: {
            title: 'test',
            description: 'test',
            content: 'test',
            categories: [new_category]
          }
        },
        headers: @auth_tokens

    expect(response.status).to eq(412)
  end

  it 'publish a post' do
    new_post = create(:post)

    post publish_post_path(new_post.id), params: { post: { publish: true } }, headers: @auth_tokens

    current_post = response_body['data']

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
    expect(current_post['attributes']['published']).to be true
  end

  it 'publish a wrong post' do
    post publish_post_path(0), params: { post: { publish: true } }, headers: @auth_tokens

    expect(response.status).to eq(412)
  end

  it 'destroy a post' do
    post_to_destroy = create(:post)

    expect do
      delete post_path(post_to_destroy.id), headers: @auth_tokens
    end.to change(Post, :count).by(-1)
    expect(response.status).to eq(200)
  end

  it 'not destroy a wrong post' do
    delete post_path(0), headers: @auth_tokens

    expect(response.status).to eq(412)
  end
end
