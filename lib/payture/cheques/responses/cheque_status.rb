module Payture::Cheques
  module Responses
    class ChequeStatus
      attr_reader :sent, :cheque, :error_code, :status

      def initialize(args)
        @sent = args["Sended"]
        @cheque = args["Cheque"]
        @status = args["Status"]
        @error_code = args["ErrCode"] || Status::ERROR_STATES[@status]
      end

      def processed?
        @sent == true && @status == 'Created'
      end
    end
  end
end
