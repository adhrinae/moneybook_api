require 'spec_helper'

describe JwtIssuer do
  let(:token) {
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJpc3MiOi" +
    "Jsb2NhbGhvc3QiLCJleHAiOjg2NDAwfQ.rcsYcACaeGkCPiZsks6FJqBGhuz_QXrLNIugWjBDM8w"
  }

  it "encodes token as expected" do
    Time.stub :now, Time.at(0) do
      JwtIssuer.encode(1)[:auth_token].must_equal token
    end
  end

  it "decodes and returns user_id with given token" do
    Time.stub :now, Time.at(0) do
      JwtIssuer.decode(token)['user_id'].must_equal 1
    end
  end
end
