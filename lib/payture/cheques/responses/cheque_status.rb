module Payture::Cheques
  module Responses
    class ChequeStatus
      attr_reader :sent, :cheque, :err_code, :status

      def initialize(args)
        @sent = args["Sended"]
        @cheque = args["Cheque"]
        @status = args["Status"]
        @err_code = args["ErrCode"] || Status::ERROR_STATES[@status]
      end

      def success?
        @sent == true && @status == 'Created'
      end
    end
  end
end
