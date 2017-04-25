require 'spec_helper'
require_relative '../../../../apps/api/controllers/records/create'

describe Api::Controllers::Records::Create do
  include Rack::Test::Methods
  let(:action) { Api::Controllers::Records::Create.new }
  let(:params) { { record: { amount: 1000, description: 'Spending Money' } } }

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

  describe 'with valid params' do
    it 'is successful' do
      header 'Authorization', @token
      post '/api/records', params
      last_response.status.must_equal 201
    end
  end

  describe 'with invalid params' do
    it 'returns 422' do
      header 'Authorization', @token
      post '/api/records', params.merge(record: {})
      last_response.status.must_equal 422
    end
  end

  describe 'with invalid token' do
    it 'returns 401' do
      header 'Authorization', ''
      post '/api/records', params
      last_response.status.must_equal 401
    end
  end
end
