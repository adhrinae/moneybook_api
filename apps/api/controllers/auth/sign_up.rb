module Api::Controllers::Auth
  class SignUp
    include Api::Action

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    params do
      required(:user).schema do
        required(:email).filled(:str?, format?: VALID_EMAIL_REGEX)
        required(:password).filled(:str?).confirmation
      end
    end

    def initialize(interactor: UserSignUp)
      @interactor = interactor
    end

    def call(params)
      halt 422, 'Invalid Parameters' unless params.valid?

      result = @interactor.new(params.get(:user)).call
      status 201, result.user.show_info.to_json
    end
  end
end
