module Api::Controllers::Records
  module SetRecord
    def self.included(action)
      action.class_eval do
        before :set_record
      end
    end

    private

    def set_record
      @record = RecordRepository.new.find(params[:id])
      halt 404 unless @record
    end
  end
end
