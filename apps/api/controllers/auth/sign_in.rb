module Api::Controllers::Auth
  class SignIn
    include Api::Action
    include Api::Authentication::Skip

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    params do
      required(:user).schema do
        required(:email).filled(:str?, format?: VALID_EMAIL_REGEX)
        required(:password).filled(:str?)
      end
    end

    def call(params)
      halt 422, 'Invalid Parameters' unless params.valid?
      email = params.get(:user, :email)
      password = params.get(:user, :password)

      user = UserRepository.new.find_by_email(email)

      if user && user.valid_password?(password)
        token = JwtIssuer.encode(user.id)

        status 201, token.to_json
      else
        halt 401, 'Authentication Failed'
      end
    end
  end
end
