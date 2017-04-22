require "spec_helper"

describe UserSignUp do
  let(:user_attr) { { email: 'foo@bar.com', password: 'secret' } }
  let(:interactor) { UserSignUp.new(user_attr) }

  after do
    UserRepository.new.clear
  end

  it "creates a user" do
    user = interactor.call.user

    UserRepository.new.find(user.id).wont_be_nil
  end
end
