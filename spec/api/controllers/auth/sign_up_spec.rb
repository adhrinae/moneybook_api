require 'spec_helper'
require_relative '../../../../apps/api/controllers/auth/sign_up'

describe Api::Controllers::Auth::SignUp do
  let(:action) { Api::Controllers::Auth::SignUp.new }
  let(:params) do
    {
      user: {
        email: "foo@bar.com",
        password: "secret",
        password_confirmation: "secret"
      }
    }
  end

  before do
    UserRepository.new.clear
  end

  describe 'with valid params' do
    it 'is successful' do
      response = action.call(params)
      response[0].must_equal 201
    end
  end

  describe 'with invalid params' do
    it 'returns 422' do
      response = action.call({})
      response[0].must_equal 422
    end
  end
end
