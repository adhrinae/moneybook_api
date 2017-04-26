module Api::Controllers::Records
  class Index
    include Api::Action

    def initialize(repository: RecordRepository.new)
      @repo = repository
    end

    def call(params)
      status 200, get_records.to_json
    end

    private

    attr_reader :repo

    def get_records
      records = repo.by_user(current_user).map { |record| record.to_h }

      {}.tap do |hash|
        hash.store(:records, records)
      end
    end
  end
end
