class JwtIssuer
  DEFAULT_EXPIRE_TIME = 86400 # 24 hours

  def self.encode(user_id, exp = Time.now.to_i + DEFAULT_EXPIRE_TIME)
    payload = { user_id: user_id, iss: ENV['JWT_ISSUER'], exp: exp }
    token = JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
    { auth_token: token }
  end

  def self.decode(token)
    JWT.decode(token, ENV['JWT_SECRET'], true)[0]
  end
end
