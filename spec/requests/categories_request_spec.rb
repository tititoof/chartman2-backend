# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  include ActionController::RespondWith

  before do
    Faker::UniqueGenerator.clear
    @current_user = User.new(name: 'Test user name', email: 'toto@toto.fr', password: 'password', admin: true)
    @current_user.save
    
    login
    
    @auth_tokens = get_auth_params_from_login_response_headers(response)
  end

  it 'get all categories' do
    get categories_path, headers: @auth_tokens

    expect(response.status).to eq(200)
  end

  it 'create a category' do
    category = { name: 'test' }
    
    post categories_path, params: { category: category }, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
  end

  it 'cannot create a category with wrong parameter' do
    category = { gnu: 'gnu' }
    
    post categories_path, params: { category: category }, headers: @auth_tokens

    expect(response.status).to eq(412)
  end

  it 'show a category' do
    new_category = FactoryBot.create(:category)
    
    get category_url({ id: new_category.id }), headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
  end

  it 'update a category name' do
    new_category = FactoryBot.create(:category)
    new_category.name = "#{new_category.name} changed"
    
    put category_path(new_category.id), params: { category: { name: new_category.name } }, headers: @auth_tokens
    
    current_category = response_body['data']

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('category')
    expect(current_category['attributes']['name']).to eq new_category.name
  end

  it 'destroy a category' do
    category_to_destroy = FactoryBot.create(:category)

    expect do
      delete category_path(category_to_destroy), headers: @auth_tokens
    end.to change(Category, :count).by(-1)
    
    expect(response.status).to eq(200)
  end
end
