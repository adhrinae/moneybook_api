module Api::Controllers::Auth
  class SignIn
    include Api::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
