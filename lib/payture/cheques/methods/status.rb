# frozen_string_literal: true

module Payture::Cheques
  module Methods
    class Status < Base
      private

      def url
        "#{config.base_url}/Status"
      end

      def params(cheque_id:)
        {
          Key: config.merchant_id,
          Password: config.password,
          Id: cheque_id,
        }
      end

      def response_class
        Responses::Status
      end
    end
  end
end
