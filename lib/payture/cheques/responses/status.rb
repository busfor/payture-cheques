# frozen_string_literal: true

module Payture::Cheques
  module Responses
    class Status < Base
      ERROR_STATES = {
        'Unauthorized': 'Cannot authorize with terminal',
        'NotFound': 'Cheque not found',
        'Timeout': 'timeout while connected to terminal',
        'Unknown': 'Unknown, cheque not created',
      }.freeze

      def success?
        body['Success'] == 'True' && body['Status'] == 'Created'
      end

      def error_code
        body['ErrCode'] || ERROR_STATES[body['Status']]
      end
    end
  end
end
