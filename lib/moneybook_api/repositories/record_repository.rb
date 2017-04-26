class RecordRepository < Hanami::Repository
  def by_user(user)
    records.where(user_id: user.id)
  end
end
