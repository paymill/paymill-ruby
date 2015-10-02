require 'spec_helper'

module Paymill
  describe Client do

    client_id = nil

    context '::find' do
      it 'should throw AuthenticationError when API_KEY is not set', :vcr do
        Paymill.api_key = nil
        expect{ Client.find( 'fake_id' ) }.to raise_error AuthenticationError
        Paymill.api_key = ENV['PAYMILL_API_TEST_PRIVATE_KEY']
      end

      it 'should throw NotFoundError when unexisting client id given', :vcr do
        expect{ Client.find( 'fake_id' ) }.to raise_error PaymillError
      end

    end

    context '::create' do
      it 'should create new client with given email and description', :vcr do
        client = Client.create( email: 'john.rambo@qaiware.com', description: 'Main caracter in First Blood' )
        client_id = client.id

        expect( client ).to be_a Client

        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to eq 'Main caracter in First Blood'

        expect( client.id ).to be_a String
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil


        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it 'should create new client with given email', :vcr do
        client = Client.create( email: 'john.rambo@qaiware.com' )
        expect( client ).to be_a Client

        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to be_nil

        expect( client.id ).to be_a String
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil


        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it 'should create new client with given description', :vcr do
        client = Client.create( description: 'Main caracter in First Blood' )
        expect( client ).to be_a Client

        expect( client.email ).to be_nil
        expect( client.description ).to eq 'Main caracter in First Blood'

        expect( client.id ).to be_a String
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil

        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it 'should create new client with no arguments', :vcr do
        client = Client.create()
        expect( client ).to be_a Client

        expect( client.email ).to be_nil
        expect( client.description ).to be_nil

        expect( client.id ).to be_a String
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil

        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it 'should throw ArgumentError when creating with invalid argument', :vcr do
        expect{ Client.create( foo: 'foo' ) }.to raise_error ArgumentError
      end
    end

    context '::update' do
      it "should update client's email and description", :vcr do
        client = Client.find( client_id )
        created_at = client.created_at

        client.email = 'john.ruby.rambo@qaiware.com'
        client.description = 'Main Ruby caracter in First Blood'

        client.update

        expect( client ).to be_a Client
        expect( client.email ).to eq 'john.ruby.rambo@qaiware.com'
        expect( client.description ).to eq 'Main Ruby caracter in First Blood'
        expect( client.id ).to be_a String
        expect( client.created_at ).to eq created_at
        expect( client.created_at ).to be < client.updated_at
        expect( client.app_id ).to be_nil
        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it "should update client's email", :vcr do
        client = Client.find( client_id )
        created_at = client.created_at

        client.email = 'john.rambo@qaiware.com'

        client.update

        expect( client ).to be_a Client
        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to eq 'Main Ruby caracter in First Blood'
        expect( client.id ).to be_a String
        expect( client.created_at ).to eq created_at
        expect( client.created_at ).to be < client.updated_at
        expect( client.app_id ).to be_nil
        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it "should update client's description", :vcr do
        client = Client.find( client_id )
        created_at = client.created_at

        client.description = 'Main caracter in First Blood'

        client.update

        expect( client ).to be_a Client
        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to eq 'Main caracter in First Blood'
        expect( client.id ).to be_a String
        expect( client.created_at ).to eq created_at
        expect( client.created_at ).to be < client.updated_at
        expect( client.app_id ).to be_nil
        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it "should throw NoMethodError when updating unupdateable field", :vcr do
        client = Client.find( client_id )
        expect{ client.app_id = 'fake_app_id' }.to raise_error NoMethodError
      end
    end

    context '::delete' do
      it 'should delete existing client', :vcr do
        client = Client.find( client_id )
        expect( client.delete() ).to be_nil
      end
    end

    context '::all' do
      it 'should get all clients', :vcr do
        clients = Client.all

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
      end

      xit 'should get all clients with sorting and filters', :vcr do
        # 2015-07-08 00:43:14 to 2015-07-14 23:23:14
        clients = Client.all( order: [:email_asc], filters: [created_at: "1436316194-1436916194"] )

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
        expect( clients.size ).to be 20
      end

      xit 'should get all clients with filters', :vcr do
        clients = Client.all( filters: [email: 'john.rambo@qaiware.com', description: 'Boom, boom, shake the room'] )

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
        expect( clients.size ).to be 20
      end

      xit 'should get all clients with order and count', :vcr do
        clients = Client.all( order: [:email, :created_at_desc], count: 30 )

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
        expect( clients.size ).to be 30
      end

      xit 'should get all clients with order, count and offset', :vcr do
        clients = Client.all( order: [:email, :created_at_desc], count: 30, offset: 10 )

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
        expect( clients.size ).to be 30
      end

    end
  end
end
