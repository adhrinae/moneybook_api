require 'spec_helper'
require_relative '../../../../apps/api/controllers/records/index'

describe Api::Controllers::Records::Index do
  include Rack::Test::Methods

  def app
    Hanami.app
  end

  before do
    @user = UserRepository.new.create(email: 'foo@bar.com', password_digest: 'secret')
    @token = JwtIssuer.encode(@user.id)[:auth_token]
  end

  after do
    UserRepository.new.clear
  end

  describe 'with valid token' do
    it 'is successful' do
      header 'Authorization', @token
      get '/api/records'
      last_response.status.must_equal 200
    end
  end

  describe 'with invalid token' do
    it 'returns 401' do
      header 'Authorization', ''
      get '/api/records'
      last_response.status.must_equal 401
    end
  end
end
