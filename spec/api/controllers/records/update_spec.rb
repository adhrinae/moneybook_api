require 'spec_helper'
require_relative '../../../../apps/api/controllers/records/update'

describe Api::Controllers::Records::Update do
  include Rack::Test::Methods
  let(:params) { { record: { amount: 1200, description: 'changed value' } } }

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
    it 'is successful with valid params' do
      header 'Authorization', @token
      patch "/api/records/#{@target.id}", params.to_json, "CONTENT_TYPE" => "application/json"
      last_response.status.must_equal 200
    end

    it 'is successful with invalid params' do
      header 'Authorization', @token
      patch "/api/records/#{@target.id}", {}.to_json, "CONTENT_TYPE" => "application/json"
      last_response.status.must_equal 422
    end
  end

  describe 'with invalid token' do
    it 'returns 401' do
      header 'Authorization', ''
      patch "/api/records/#{@target.id}"
      last_response.status.must_equal 401
    end
  end
end
