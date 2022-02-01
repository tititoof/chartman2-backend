# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ArticlesController', type: :request do
  before do
    Faker::UniqueGenerator.clear
  end
  
  it 'show articles from category' do
    category = FactoryBot.create(:category)

    get "/articles/category/#{category.id}"

    expect(response.status).to eq(200)
  end

  it 'show article' do
    post = FactoryBot.create(:post)

    get "/article/#{post.id}"

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('post')
  end

  it 'show category' do
    category = FactoryBot.create(:category)

    get "/category/#{category.id}"

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
  end

  it 'show categories' do
    2.times do 
      category = FactoryBot.create(:category)
    end

    get '/articles/categories'

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('categories')
  end
end
