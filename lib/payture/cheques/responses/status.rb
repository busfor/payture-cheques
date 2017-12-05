# frozen_string_literal: true

module Payture::Cheques
  module Responses
    class Status < Base
      ERROR_STATES = {
        'Unauthorized' => 'CANNOT_AUTHORIZE_TERMINAL',
        'NotFound' => 'NOT_FOUND',
        'Timeout' => 'TIMEOUT',
        'Unknown' => 'UNKNOWN',
      }.freeze

      def cheques
        @cheques ||= body['Cheques'].map { |c| ChequeStatus.new(c) }
      end

      def success?
        body['Success'] == 'True' && body['Status'] == 'Created'
      end

      def error_code
        body['ErrCode'] || ERROR_STATES[body['Status']]
      end
    end
  end
end
