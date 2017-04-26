module Api::Controllers::Records
  class Update
    include Api::Action
    include SetRecord

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

      begin
        updated_record = repo.update(record.id, params.get(:record))
        status 200, updated_record.to_h.to_json
      rescue
        status 400, { error: 'There was a problem during the process' }.to_json
      end
    end

    private

    attr_reader :repo, :record
  end
end
