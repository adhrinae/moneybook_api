require 'spec_helper'
require 'bcrypt'
require_relative '../../../../apps/api/controllers/auth/sign_in'

describe Api::Controllers::Auth::SignIn do
  let(:params) { { user: { email: 'foo@bar.com', password: 'secret' } } }
  let(:action) { Api::Controllers::Auth::SignIn.new }

  before do
    encrypted = BCrypt::Password.create('secret')
    user = User.new(email: 'foo@bar.com', password_digest: encrypted)
    UserRepository.new.create(user)
  end

  after do
    UserRepository.new.clear
  end

  describe 'with valid params' do
    it "returns 201" do
      response = action.call(params)
      response[0].must_equal 201
    end
  end

  describe 'with wrong user email' do
    let(:wrong_user) { params.tap { |p| p[:user][:email] = 'foo@baz.com' } }

    it "returns 401" do
      response = action.call(wrong_user)
      response[0].must_equal 401
    end
  end

  describe 'with invalid params' do
    it "returns 422" do
      response = action.call(params.merge(user: {}))
      response[0].must_equal 422
    end
  end
end
