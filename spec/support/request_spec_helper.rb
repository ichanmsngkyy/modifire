module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  # Helper to set Authorization header
  def auth_headers(user)
    token = jwt_token_for(user)
    { 'Authorization' => "Bearer #{token}" }
  end

  # Generate JWT token for testing
  def jwt_token_for(user)
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  end
end
