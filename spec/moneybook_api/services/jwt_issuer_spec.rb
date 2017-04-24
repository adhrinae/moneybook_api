require 'spec_helper'

describe JwtIssuer do
  it "encodes token" do
    JwtIssuer.encode(1)[:auth_token].wont_be_nil
  end

  it "decodes and returns user_id with given token" do
    token = JwtIssuer.encode(1)[:auth_token]
    JwtIssuer.decode(token)['user_id'].must_equal 1
  end

  it "throws error with invalid token" do
    assert_raises { JwtIssuer.decode('invalid token') }
  end

  it "expires token after given expire time" do
    token = JwtIssuer.encode(1, 0)[:auth_token]
    assert_raises { JwtIssuer.decode(token) }
  end
end
