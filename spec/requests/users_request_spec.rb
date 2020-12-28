# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include ActionController::RespondWith

  before do
    @current_user = User.new(name: 'Test user name', email: 'toto@toto.fr', password: 'password', admin: true)
    @current_user.save
    login
    @auth_tokens = get_auth_params_from_login_response_headers(response)
  end

  it 'show current user' do
    get "/users/#{@current_user.id}", headers: @auth_tokens

    expect(response.status).to eq(200)
  end
end
