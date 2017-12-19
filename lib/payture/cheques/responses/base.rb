# frozen_string_literal: true

module Payture::Cheques
  module Responses
    class Base
      attr_reader :body

      def initialize(body)
        @body = body
      end

      def success?
        body['Success'] == 'True'
      end

      def error?
        !success?
      end

      def error_code
        body['ErrCode']
      end

      def error_messages
        body['ErrMessages']
      end
    end
  end
end
