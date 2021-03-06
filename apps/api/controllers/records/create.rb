module Api::Controllers::Records
  class Create
    include Api::Action

    params do
      required(:record).schema do
        required(:amount).filled(:int?)
        optional(:description).filled(:str?)
      end
    end

    def initialize(repository: RecordRepository.new)
      @repo = repository
    end

    def call(params)
      halt 422, 'Invalid Parameters' unless params.valid?

      user = current_user
      amount = params.get(:record, :amount)
      description = params.get(:record, :description)

      record = @repo.create(
        user_id: user.id,
        amount: amount,
        description: description
      )

      status 201, record.to_h.to_json
    end
  end
end
