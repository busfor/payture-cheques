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

    refute response.processing_error?
    assert_nil response.error_code
  end

  it 'returns processing_error for status ServiceUnavailable' do
    response =
      VCR.use_cassette('status_service_unavailable') do
        @client.status(cheque_id: 'busfor-123')
      end

    assert response.success?
    refute response.processed?

    assert response.processing_error?
    assert_nil response.error_code
  end

  it 'returns success cheques' do
    response =
      VCR.use_cassette('status_success') do
        @client.status(cheque_id: 'busfor-123')
      end

    assert_equal 1, response.cheques.size

    cheque = response.cheques.first

    assert cheque.sent
    assert cheque.processed?
    assert_equal 'Created', cheque.status

    refute response.processing_error?
    assert_nil cheque.error_code
  end
end
