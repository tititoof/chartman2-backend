# frozen_string_literal: true

module RequestSpecHelper
  def login
    post user_session_path, params: login_params, headers: login_headers
  end

  def get_auth_params_from_login_response_headers(response)
    {
      'access-token' => response.headers['access-token'],
      'client' => response.headers['client'],
      'uid' => response.headers['uid'],
      'expiry' => response.headers['expiry'],
      'token-type' => response.headers['token-type']
    }
  end

  def response_body
    JSON.parse(response.body)
  end

  def login_params
    {
      email: @current_user.email,
      password: 'password'
    }.to_json
  end

  def login_headers
    {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end
end
