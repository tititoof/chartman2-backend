# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  include ActionController::RespondWith

  it 'get all posts from index' do
    get posts_path

    expect(response.status).to eq(200)
  end

  it 'create a post' do
    user = FactoryBot.create(:user)
    post = { title: 'test', content: 'gnagnagna', user_id: user.id }
    post posts_path, params: post

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
  end

  it 'show a post' do
    new_post = FactoryBot.create(:post)
    get post_path(new_post.id)

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
  end

  it 'update a post' do
    new_post = FactoryBot.create(:post)
    new_post.title = "#{new_post.title} changed"
    put post_path(new_post.id), params: { title: new_post.title, content: new_post.content, user_id: new_post.user.id }
    current_post = response_body['data']

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
    expect(current_post['attributes']['title']).to eq new_post.title
  end

  it 'destroy a post' do
    post_to_destroy = FactoryBot.create(:post)

    expect do
      delete post_path(post_to_destroy)
    end.to change(Post, :count).by(-1)
    expect(response.status).to eq(200)
  end
end
