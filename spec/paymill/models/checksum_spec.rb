require 'spec_helper'

module Paymill
  describe Checksum do
    let( :billing_address ) {
      Address.new(
        name: 'Primary', street_address: 'Rambo Str.', street_address_addition: '', city: 'Sofia',
        state: 'Sofia', postal_code: 1234, country: 'BG', phone: '088 41 555 27'
      )
    }
    let( :rambo_poster ) {
      ShoppingCartItem.new(
        name: "Rambo Poster", description: "John J. Rambo", amount: 2200, quantity: 3, item_number: "898-24342-343", url: "http://www.store.com/items/posters/12121-rambo"
      )
    }
    let( :comando_poster ) {
      ShoppingCartItem.new(
        name: "Comando Poster", description: "John Matrix", amount: 3100, quantity: 1, item_number: "898-24342-341", url: "http://www.store.com/items/posters/12121-comando"
      )
    }

    context '::create' do
      it 'should create new checksum with minimum parameters', :vcr do
        checksum = Checksum.create( checksum_type: 'paypal', amount: 4200, currency: 'EUR', description: 'Chuck Testa', return_url: 'https://testa.com', cancel_url: 'https://test.com/cancel' )

        expect( checksum.action ).to eq 'transaction'
        expect( checksum.checksum ).to be_a String
        expect( checksum.data ).to eq 'amount=4200&currency=EUR&description=Chuck+Testa&return_url=https%3A%2F%2Ftesta.com&cancel_url=https%3A%2F%2Ftest.com%2Fcancel'
        expect( checksum.id ).to be_a String
        expect( checksum.type ).to eq 'paypal'
        expect( checksum.app_id ).to be_nil
        expect( checksum.created_at ).to be_a Time
        expect( checksum.updated_at ).to be_a Time
      end

      it 'should create new checksum with minimum parameters and billing address', :vcr do
        checksum = Checksum.create( checksum_type: 'paypal', amount: 4200, currency: 'EUR', description: 'Chuck Testa', return_url: 'https://testa.com', cancel_url: 'https://test.com/cancel', billing_address: billing_address )

        expect( checksum.action ).to eq 'transaction'
        expect( checksum.checksum ).to be_a String
        expect( checksum.data ).to eq 'amount=4200&currency=EUR&description=Chuck+Testa&return_url=https%3A%2F%2Ftesta.com&cancel_url=https%3A%2F%2Ftest.com%2Fcancel&billing_address%5Bname%5D=Primary&billing_address%5Bstreet_address%5D=Rambo+Str.&billing_address%5Bcity%5D=Sofia&billing_address%5Bstate%5D=Sofia&billing_address%5Bpostal_code%5D=1234&billing_address%5Bcountry%5D=BG&billing_address%5Bphone%5D=088+41+555+27'
        expect( checksum.id ).to be_a String
        expect( checksum.type ).to eq 'paypal'
        expect( checksum.app_id ).to be_nil
        expect( checksum.created_at ).to be_a Time
        expect( checksum.updated_at ).to be_a Time
      end

      it 'should create new checksum with minimum parameters and items', :vcr do
        checksum = Checksum.create( checksum_type: 'paypal', amount: 9700, currency: 'EUR', description: 'Chuck Testa', return_url: 'https://testa.com', cancel_url: 'https://test.com/cancel', items: [rambo_poster, comando_poster] )

        expect( checksum.action ).to eq 'transaction'
        expect( checksum.checksum ).to be_a String
        expect( checksum.data ).to eq 'amount=9700&currency=EUR&description=Chuck+Testa&return_url=https%3A%2F%2Ftesta.com&cancel_url=https%3A%2F%2Ftest.com%2Fcancel&items%5B0%5D%5Bname%5D=Rambo+Poster&items%5B0%5D%5Bdescription%5D=John+J.+Rambo&items%5B0%5D%5Bamount%5D=2200&items%5B0%5D%5Bquantity%5D=3&items%5B0%5D%5Bitem_number%5D=898-24342-343&items%5B0%5D%5Burl%5D=http%3A%2F%2Fwww.store.com%2Fitems%2Fposters%2F12121-rambo&items%5B1%5D%5Bname%5D=Comando+Poster&items%5B1%5D%5Bdescription%5D=John+Matrix&items%5B1%5D%5Bamount%5D=3100&items%5B1%5D%5Bquantity%5D=1&items%5B1%5D%5Bitem_number%5D=898-24342-341&items%5B1%5D%5Burl%5D=http%3A%2F%2Fwww.store.com%2Fitems%2Fposters%2F12121-comando'
        expect( checksum.id ).to be_a String
        expect( checksum.type ).to eq 'paypal'
        expect( checksum.app_id ).to be_nil
        expect( checksum.created_at ).to be_a Time
        expect( checksum.updated_at ).to be_a Time
      end

    end
  end
end
