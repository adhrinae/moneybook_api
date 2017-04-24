require 'spec_helper'
require 'bcrypt'

describe User do
  let(:params) { { email: 'foo@bar.com', password: 'secret' } }
  let(:encrypted) { BCrypt::Password.create(params[:password]) }
  let(:attributes) { { email: params[:email], password_digest: encrypted } }

  before do
    @user = User.new(attributes)
  end

  it "show_info doesn't include password_digest" do
    @user.show_info.wont_include(:password_digest)
  end

  it "validates given password is equal to user's password" do
    assert @user.valid_password?(params[:password])
  end
end
