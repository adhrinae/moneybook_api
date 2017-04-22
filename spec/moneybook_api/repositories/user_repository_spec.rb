require 'spec_helper'

describe UserRepository do
  before do
    @repo = UserRepository.new
    @repo.create(email: 'foo@bar.com', password_digest: 'secret1')
    @repo.create(email: 'foo@baz.com', password_digest: 'secret1')
  end

  after do
    @repo.clear
  end

  it "returns accurate user with email address" do
    email = 'foo@bar.com'
    @repo.find_by_email(email).must_equal @repo.first
  end
end
