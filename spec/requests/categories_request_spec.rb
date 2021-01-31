# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  include ActionController::RespondWith

  before do
    @current_user = User.new(name: 'Test user name', email: 'toto@toto.fr', password: 'password', admin: true)
    @current_user.save
    login
    @auth_tokens = get_auth_params_from_login_response_headers(response)
  end

  it 'get all categories from index' do
    get categories_path, headers: @auth_tokens

    expect(response.status).to eq(200)
  end

  it 'create' do
    category = { name: 'test' }
    post categories_path, params: category, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
  end

  it 'not create with wrong parameter' do
    category = {}
    post categories_path, params: category, headers: @auth_tokens

    expect(response.status).to eq(412)
  end

  it 'show' do
    new_category = FactoryBot.create(:category)
    get category_path(new_category.id), headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
  end

  it 'update' do
    new_category = FactoryBot.create(:category)
    new_category.name = "#{new_category.name} changed"
    put category_path(new_category.id), params: { name: new_category.name }, headers: @auth_tokens
    current_category = response_body['data']

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
    expect(current_category['attributes']['name']).to eq new_category.name
  end

  it 'destroy' do
    category_to_destroy = FactoryBot.create(:category)

    expect do
      delete category_path(category_to_destroy), headers: @auth_tokens
    end.to change(Category, :count).by(-1)
    expect(response.status).to eq(200)
  end
end
