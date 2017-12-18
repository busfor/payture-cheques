module Payture::Cheques
  module Responses
    class ChequeStatus
      attr_reader :sent, :cheque, :error_code, :status

      def initialize(data)
        @sent = data['Sended']
        @cheque = data['Cheque']
        @status = data['Status']
        @error_code = data['ErrCode'] || Status::ERROR_STATES[@status]
      end

      def processed?
        error_code.nil? && @sent == true && @status == 'Created'
      end

      def processing_error?
        !error_code.nil?
      end
    end
  end
end
