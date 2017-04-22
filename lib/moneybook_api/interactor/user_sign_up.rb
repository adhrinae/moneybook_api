require "hanami/interactor"
require "bcrypt"

class UserSignUp
  include Hanami::Interactor
  include BCrypt

  expose :user

  def initialize(user_attr, encryptor: nil, repo: nil)
    @user_attr = user_attr
    @encryptor = encryptor || BCrypt::Password
    @repo = repo || UserRepository.new
  end

  def call
    safe_user = encrypt_user(user_attr)
    @user = @repo.create(safe_user)
  end

  private

  attr_reader :user_attr

  def encrypt_user(attributes)
    password = @encryptor.create(attributes[:password])

    { email: user_attr[:email], password_digest: password }
  end
end
