# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  include ActionController::RespondWith

  it 'get all categories from index' do
    get categories_path

    expect(response.status).to eq(200)
  end

  it 'create a category' do
    category = { name: 'test' }
    post categories_path, params: category

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
  end

  it 'show a category' do
    new_category = FactoryBot.create(:category)
    get category_path(new_category.id)

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
  end

  it 'update a category' do
    new_category = FactoryBot.create(:category)
    new_category.name = "#{new_category.name} changed"
    put category_path(new_category.id), params: { name: new_category.name }
    current_category = response_body['data']

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
    expect(current_category['attributes']['name']).to eq new_category.name
  end

  it 'destroy a category' do
    category_to_destroy = FactoryBot.create(:category)

    expect do
      delete category_path(category_to_destroy)
    end.to change(Category, :count).by(-1)
    expect(response.status).to eq(200)
  end
end
