# frozen_string_literal: true

require 'test_helper'

describe Payture::Cheques::Methods::Create do
  before do
    @client = Payture::Cheques.client(
      host: 'sandbox3.payture.com',
      merchant_id: 'MerchantId',
      password: '1234',
    )
  end

  it 'returns success response' do
    cheque = JSON.parse('{
             "Message":"test",
             "Type":1,
             "Positions":[
                {
                   "Quantity":1.000,
                   "Price":111.45,
                   "Tax":1,
                   "Text":"Булка"
                }
             ],
             "CheckClose":{
                "Payments":[
                   {
                      "Type":1,
                      "Amount":123.45
                   }
                ],
                "TaxationSystem":1
             },
             "CustomerContact":"nikita.popovsky@payture.com"
          }
       ')
    response =
      VCR.use_cassette('create_success') do
        @client.create(
          cheque_id: 'busfor-123',
          inn: 7710140679,
          content: cheque
        )
      end

    assert response.success?
    refute response.error_code
  end

  it 'returns conflict status if id is duplicate' do
    cheque = JSON.parse('{
             "Message":"test",
             "Type":1,
             "Positions":[
                {
                   "Quantity":1.000,
                   "Price":111.45,
                   "Tax":1,
                   "Text":"Булка"
                }
             ],
             "CheckClose":{
                "Payments":[
                   {
                      "Type":1,
                      "Amount":123.45
                   }
                ],
                "TaxationSystem":1
             },
             "CustomerContact":"nikita.popovsky@payture.com"
          }
       ')
    response =
      VCR.use_cassette('create_conflict') do
        @client.create(
          cheque_id: 'busfor-123',
          inn: 7710140679,
          content: cheque
        )
      end

    refute response.success?
    assert_equal 'DUPLICATE_ID', response.error_code
  end
end
