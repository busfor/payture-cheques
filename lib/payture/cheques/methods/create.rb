# frozen_string_literal: true

module Payture::Cheques
  module Methods
    class Create < Base
      private

      def url
        "#{config.base_url}/Create"
      end

      def params(cheque_id:, inn:, content:, group: nil)
        message = content.delete("Message") || content.delete(:Message)
        additional_messages = content.delete("AdditionalMessages") || content.delete(:AdditionalMessages)
        params = {
          Key: config.merchant_id,
          Password: config.password,
          Message: message,
          AdditionalMessages: additional_messages || [],
          Cheque: {
            Id: cheque_id,
            INN: inn,
            Content: content,
          },
        }
        params[:Group] = group if group
        params
      end

      def response_class
        Responses::Create
      end
    end
  end
end
