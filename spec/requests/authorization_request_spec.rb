# frozen_string_literal: true

require 'rails_helper'
include ActionController::RespondWith

# The authentication header looks something like this:
# {"access-token"=>"abcd1dMVlvW2BT67xIAS_A", "token-type"=>"Bearer", "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w", "expiry"=>"1519086891", "uid"=>"darnell@konopelski.info"}
RSpec.describe 'Authorization', type: :request do
  before(:each) do
    @current_user = FactoryBot.create(:user)
  end

  it 'gives you an authentication code if you are an existing user and you satisfy the password' do
    login

    expect(response.has_header?('access-token')).to eq(true)
  end

  def login
    post user_session_path,
         params: { email: @current_user.email, password: 'password' }.to_json,
         headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    { 'access-token' => token, 'client' => client, 'uid' => uid, 'expiry' => expiry, 'token-type' => token_type }
  end
end
