# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  it 'show articles from category' do
    category = FactoryBot.create(:category)
    get "/visitors/articles/#{category.id}"

    expect(response.status).to eq(200)
  end

  it 'show article' do
    post = FactoryBot.create(:post)
    get "/visitors/article/#{post.id}"

    expect(response.status).to eq(200)
  end

  it 'show category' do
    category = FactoryBot.create(:category)
    get "/visitors/category/#{category.id}"

    expect(response.status).to eq(200)
  end

  it 'show categories' do
    get '/visitors/categories'

    expect(response.status).to eq(200)
  end
end
