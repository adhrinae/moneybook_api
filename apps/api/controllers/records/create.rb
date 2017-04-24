module Api::Controllers::Records
  class Create
    include Api::Action

    params do
      required(:record).schema do
        required(:amount).filled(:int?)
        optional(:description).filled(:str?)
      end
    end

    def call(params)
      halt 422, 'Invalid Parameters' unless params.valid?
      user = UserRepository.new.first
      amount = params.get(:record, :amount)
      description = params.get(:record, :description)

      record = RecordRepository.new.create(
        user_id: user.id,
        amount: amount,
        description: description
      )

      status 201, record.to_json
    end
  end
end
