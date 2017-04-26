require 'spec_helper'

describe RecordRepository do
  before do
    @repo = RecordRepository.new
    @user = UserRepository.new.create(email: 'foo@bar.com', password_digest: 'secret')
    @another_user = UserRepository.new.create(email: 'foo@baz.com', password_digest: 'secret')

    10.times do
      user_id = [@user.id, @another_user.id].sample
      @repo.create(user_id: user_id, amount: rand(10000), description: 'for Test')
    end
  end

  after do
    RecordRepository.new.clear
    UserRepository.new.clear
  end

  describe '#by_user' do
    it 'returns a collection of records by specific user' do
      records = @repo.by_user(@user).to_a

      assert records.all? { |record| record.user_id == @user.id }
    end
  end
end
