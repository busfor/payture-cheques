# frozen_string_literal: true

require 'test_helper'

describe Payture::Cheques::Methods::Status do
  before do
    @client = Payture::Cheques.client(
      host: 'sandbox3.payture.com',
      merchant_id: 'MerchantId',
      password: '1234',
    )
  end

  it 'returns success response' do
    response =
      VCR.use_cassette('status_success') do
        @client.status(cheque_id: 'busfor-123')
      end

    assert response.success?
    assert response.processed?
    refute response.error_code
    assert_equal 1, response.cheques.size

    cheque_status = response.cheques.first
    assert cheque_status.processed?
    assert cheque_status.sent
    assert_equal 'Created', cheque_status.status
  end
end
