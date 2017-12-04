# frozen_string_literal: true

module Payture::Cheques
  module Responses
    class Create < Base
      ERROR_STATES = {
        'Conflict': 'Id already used',
        'BadRequest': 'Bad data format',
      }.freeze

      def success?
        body['Success'] == 'True' && body['Status'] == 'Accepted'
      end

      def error_code
        body['ErrCode'] || ERROR_STATES[body['Status']]
      end
    end
  end
end
