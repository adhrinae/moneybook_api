require 'spec_helper'
require 'bcrypt'

describe User do
  let(:params) { { email: 'foo@bar.com', password: 'secret' } }
  let(:encrypted) { BCrypt::Password.create(params[:password]) }
  let(:attributes) { { email: params[:email], password_digest: encrypted } }

  before do
    @user = User.new(attributes)
  end

  it "should be initialized with email and password" do
    @user.email.must_equal 'foo@bar.com'
  end

  it "password_digest returns the encrypted value" do
    @user.password_digest.wont_equal 'secret'
  end

  it "show_info doesn't include password_digest" do
    @user.show_info.wont_include(:password_digest)
  end
end
