require 'spec_helper'

module Paymill
  describe Transaction do

    let( :amount ) { 2990 }
    let( :currency ) { 'USD' }
    let( :client ) { Client.create( email: 'rocky.balboa@qaiware.com' ) }

    transaction_id = nil

    context '::create' do
      before( :each ) do
        uri = URI.parse("https://test-token.paymill.com?transaction.mode=CONNECTOR_TEST&channel.id=941569045353c8ac2a5689deb88871bb&jsonPFunction=paymilljstests&account.number=4111111111111111&account.expiry.month=12&account.expiry.year=2015&account.verification=123&account.holder=John%20Rambo&presentation.amount3D=3201&presentation.currency3D=EUR")
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth( ENV['PAYMILL_API_TEST_KEY'], "" )
        response = https.request(request)
        @token = response.body.match('tok_[a-z|0-9]+')[0]
        @payment = Payment.create( token: @token, client: client.id )
        @preauth = Preauthorization.create( payment: @payment, amount: amount, currency: currency, description: 'The Italian Stallion' )
      end

      it 'should create transaction with token', :vcr do
        transaction = Transaction.create( token: @token, amount: amount, currency: currency )
        transaction_id = transaction.id

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to be_empty
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '0000.9999.0000'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment ).to be_a Payment
        expect( transaction.client ).to be_a Client
        expect( transaction.preauthorization ).to be_nil
        expect( transaction.app_id ).to be_nil
      end

      it 'should create transaction with token and description', :vcr do
        transaction = Transaction.create( token: @token, amount: amount, currency: currency, description: 'The Italian Stallion' )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to eq 'The Italian Stallion'
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '0000.9999.0000'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment ).to be_a Payment
        expect( transaction.client ).to be_a Client
        expect( transaction.preauthorization ).to be_nil
        expect( transaction.app_id ).to be_nil
      end

      it 'should create transaction with payment', :vcr do
        transaction = Transaction.create( payment: @payment, amount: amount, currency: currency )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to be_empty
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '0000.9999.0000'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment.id ).to eq @payment.id
        expect( transaction.client.id ).to eq client.id
        expect( transaction.client.email ).to eq 'rocky.balboa@qaiware.com'
        expect( transaction.app_id ).to be_nil

        expect( transaction.preauthorization ).to be_nil
      end

      it 'should create transaction with preauthorization', :vcr do
        transaction = Transaction.create( preauthorization: @preauth, amount: amount, currency: currency )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to be_empty
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '0000.9999.0000'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment.id ).to eq @payment.id
        expect( transaction.client.id ).to eq client.id
        expect( transaction.client.email ).to eq 'rocky.balboa@qaiware.com'
        expect( transaction.app_id ).to be_nil

        expect( transaction.preauthorization.id ).to eq @preauth.id
      end

      it 'should create transaction with client and payment', :vcr do
        transaction = Transaction.create( payment: @payment, amount: amount, currency: currency, client: client )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to be_empty
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '0000.9999.0000'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment.id ).to eq @payment.id
        expect( transaction.client.id ).to eq client.id
        expect( transaction.client.email ).to eq 'rocky.balboa@qaiware.com'
        expect( transaction.app_id ).to be_nil

        expect( transaction.preauthorization ).to be_nil
      end

      it 'should throw PaymillError with payment and different client', :vcr do
        expect{ Transaction.create( payment: @payment, amount: amount, currency: currency, client: Client.create() ) }.to raise_error PaymillError
      end

      it 'should throw ArgumentError when creating with token and payment', :vcr do
        expect{ Transaction.create( token: @token, payment: @payment, currency: currency, amount: amount ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating with token and payment and preauthorization', :vcr do
        expect{ Transaction.create( token: @token, payment: @payment, preauthorization: @preauth, currency: currency, amount: amount ) }.to raise_error ArgumentError
      end
    end

    context '::find' do
      it 'should find transaction by valid id', :vcr do
        expect( Transaction.find( transaction_id ).id ).to eq transaction_id
      end

      it 'should throw PaymillError when unvalid id given', :vcr do
        expect{ Transaction.find( 'fake_id' ) }.to raise_error PaymillError
      end
    end

    context '::update' do
      it 'should update existing transaction description', :vcr do
        transaction =  Transaction.find( transaction_id )

        transaction.description = 'The Italian Stallion'
        transaction.update

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to eq 'The Italian Stallion'
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '0000.9999.0000'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment ).to be_a Payment
        expect( transaction.client ).to be_a Client
        expect( transaction.preauthorization ).to be_nil
        expect( transaction.app_id ).to be_nil
        expect( transaction.created_at ).to be < transaction.updated_at
      end

      it "should throw NoMethodError when by updating transaction's amount", :vcr do
        transaction =  Transaction.find( transaction_id )

        expect{ transaction.amount = 999 }.to raise_error NoMethodError
      end
    end

  end
end
