# frozen_string_literal: true

module Payture::Cheques
  module Responses
    class Create < Base
      ERROR_STATES = {
        'Conflict' => 'DUPLICATE_ID',
        'BadRequest' => 'BAD_REQUEST_FORMAT',
      }.freeze

      def success?
        body['Success'] == true && body['Status'] == 'Accepted'
      end

      def error_code
        body['ErrCode'] || ERROR_STATES[body['Status']]
      end
    end
  end
end
