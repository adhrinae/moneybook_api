require_relative './set_record'

module Api::Controllers::Records
  class Destroy
    include Api::Action
    include SetRecord

    def initialize(repository: RecordRepository.new)
      @repo = repository
    end

    def call(params)
      begin
        repo.delete(record.id)
        status 204, { success: 'Successfully Removed' }.to_json
      rescue
        status 400, { error: 'There is a problem during the process' }.to_json
      end
    end

    private

    attr_reader :repo, :record
  end
end
