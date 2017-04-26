require 'spec_helper'
require_relative '../../../../apps/api/controllers/records/destroy'

describe Api::Controllers::Records::Destroy do
  include Rack::Test::Methods

  def app
    Hanami.app
  end

  before do
    @user = UserRepository.new.create(email: 'foo@bar.com', password_digest: 'secret')
    @token = JwtIssuer.encode(@user.id)[:auth_token]

    3.times do |i|
      RecordRepository.new.create(
        user_id: @user.id,
        amount: i * 1000,
        description: "Test #{i}")
    end

    @target = RecordRepository.new.first
  end

  after do
    UserRepository.new.clear
    RecordRepository.new.clear
  end

  describe 'with valid token' do
    it 'is successful' do
      header 'Authorization', @token
      delete "/api/records/#{@target.id}"
      last_response.status.must_equal 204
    end
  end

  describe 'with invalid token' do
    it 'returns 401' do
      header 'Authorization', ''
      delete "/api/records/#{@target.id}"
      last_response.status.must_equal 401
    end
  end
end
