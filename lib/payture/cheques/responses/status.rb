# frozen_string_literal: true

module Payture::Cheques
  module Responses
    class Status < Base
      ERROR_STATES = {
        'Unauthorized' => 'CANNOT_AUTHORIZE_TERMINAL',
        'NotFound' => 'NOT_FOUND',
        'Timeout' => 'TIMEOUT',
        'ServiceUnavailable' => 'SERVICE_UNAVAILABLE',
        'Unknown' => 'UNKNOWN',
      }.freeze

      def cheques
        @cheques ||= body['Cheques'].map { |c| ChequeStatus.new(c) }
      end

      def success?
        body['Success'] == true
      end

      def processed?
        error_code.nil? && cheques.all?(&:processed?)
      end

      def processing_error?
        !error_code.nil? || cheques.any?(&:processing_error?)
      end

      def error_code
        body['ErrCode'] || ERROR_STATES[body['Status']]
      end

      def status
        body['Status']
      end
    end
  end
end
