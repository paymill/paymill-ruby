require 'spec_helper'

module Paymill
  describe Payment do

    payment_id = nil

    let( :client ) { Client.create( email: 'john.rambo@qaiware.com') }

    context '::create' do
      context 'creditcard' do
        before( :each ) do
          uri = URI.parse("https://test-token.paymill.com?transaction.mode=CONNECTOR_TEST&channel.id=#{ENV['PAYMILL_API_TEST_PUBLIC_KEY']}&jsonPFunction=paymilljstests&account.number=4111111111111111&account.expiry.month=12&account.expiry.year=2015&account.verification=123&account.holder=Max%20Mustermann&presentation.amount3D=3201&presentation.currency3D=EUR")
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true
          request = Net::HTTP::Get.new(uri.request_uri)
          request.basic_auth( ENV['PAYMILL_API_TEST_PRIVATE_KEY'], "" )
          response = https.request(request)
          @token = response.body.match('tok_[a-z|0-9]+')[0]
        end

        it 'should create client with token', :vcr do
          payment = Payment.create( token: @token )
          payment_id = payment.id

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'creditcard'
          expect( payment.client ).to be_nil
          expect( payment.card_type ). to eq 'visa'

          expect( payment.country ).to be_nil
          expect( payment.expire_month ).to be 12
          expect( payment.expire_year ).to be 2015
          expect( payment.card_holder ).to eq 'Max Mustermann'
          expect( payment.last4 ).to eq 1111
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.id ).to be_a String
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end

        it 'should create client with token and client', :vcr do
          payment = Payment.create( token: @token, client: client.id )

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'creditcard'
          expect( payment.client ).to be_a Client
          expect( payment.client.id ).to eq client.id
          expect( payment.card_type ).to eq 'visa'

          expect( payment.country ).to be_nil
          expect( payment.expire_month ).to eq 12
          expect( payment.expire_year ).to eq 2015
          expect( payment.card_holder ).to eq 'Max Mustermann'
          expect( payment.last4 ).to eq 1111
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.id ).to be_a String
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end

        xit 'should throw exception when creating a clinent with invalid token', :vcr do
          #TODO[VNi]: We can create payment with custom string
          expect{ Payment.create( token: 'fake' ) }.to raise_error PaymillError
        end

        xit 'should throw exception when creating a clinent with invalid client id', :vcr do
          #TODO[VNi]: We can create payment with custom string
          expect{ Payment.create( token: @token, client: 'fake' ) }.to raise_error PaymillError
        end

        it 'should throw exception when creating with wrong argument name', :vcr do
          expect{ Payment.create( foo: 'fake' ) }.to raise_error ArgumentError
        end

        it 'should throw exception when creating with more arguments', :vcr do
          expect{ Payment.create( token: @token, client: client.id, foo: 'fake' ) }.to raise_error ArgumentError
        end

        it 'should throw exception when creating without arguments', :vcr do
          expect{ Payment.create() }.to raise_error ArgumentError
        end
      end

      context '::find' do
        it 'should find a payment by given valid id', :vcr do
          payment = Payment.find( payment_id )

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'creditcard'
          expect( payment.client ).to be_nil
          expect( payment.card_type ). to eq 'visa'

          expect( payment.country ).to be nil
          expect( payment.expire_month ).to eq 12
          expect( payment.expire_year ).to eq 2015
          expect( payment.card_holder ).to eq 'Max Mustermann'
          expect( payment.last4 ).to eq 1111
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.id ).to eq payment_id
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end

        it 'should throw NotFoundError when unexisting payment id given', :vcr do
          expect{ Payment.find( 'fake_id' ) }.to raise_error PaymillError
        end
      end

      context 'debit' do
        before( :each ) do
          uri = URI.parse("https://test-token.paymill.de/?transaction.mode=CONNECTOR_TEST&channel.id=14704210606b41cbb45f66819085cb8d&response.url=https://test-tds.paymill.de/end.php?parentUrl=http%253A%252F%252Fhtmlpreview.github.io%252F%253Fhttps%253A%252F%252Fgithub.com%252Fpaymill%252Fpaymill-payment-form%252Fblob%252Fmaster%252Fpaymill_payment_sepa.html&&jsonPFunction=window.paymill.transport.paymillCallback298646523&account.iban=DE12500105170648489890&account.bic=BENEDEPPYYY&account.country=DE&account.holder=John+Rambo")
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true
          request = Net::HTTP::Get.new(uri.request_uri)
          request.basic_auth( ENV['PAYMILL_API_TEST_PRIVATE_KEY'], "" )
          response = https.request(request)
          @token = response.body.match('uniqueId":"\w*')[0].split('":"').last
        end

        it 'should create client with token', :vcr do
          payment = Payment.create( token: @token )

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'debit'
          expect( payment.client ).to be_nil

          expect( payment.code ).to be_empty
          expect( payment.holder ).to eq 'John Rambo'
          expect( payment.account ).to be_empty
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.iban ).to eq 'DE1250010517******9890'
          expect( payment.bic ).to eq 'BENEDEPPYYY'

          expect( payment.id ).to be_a String
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end

        it 'should create client with token and client', :vcr do
          payment = Payment.create( token: @token, client: client.id )

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'debit'
          expect( payment.client ).to be_a Client
          expect( payment.client.id ).to eq client.id

          expect( payment.code ).to be_empty
          expect( payment.holder ).to eq 'John Rambo'
          expect( payment.account ).to be_empty
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.iban ).to eq 'DE1250010517******9890'
          expect( payment.bic ).to eq 'BENEDEPPYYY'

          expect( payment.id ).to be_a String
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end
      end
    end

    context '::delete' do
      it 'showd delete existing payment', :vcr do
        expect( Payment.find( payment_id ).delete ).to be_nil
      end
    end
  end
end
