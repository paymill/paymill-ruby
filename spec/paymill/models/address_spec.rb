require 'spec_helper'

module Paymill
  describe Address do

    context '::create' do

      it 'should raise ArgumentError when invalid parameter is given' do
        expect{
          Address.new(
            name: 'Primary',
            street_address: 'Rambo Str.',
            street_address_addition: '',
            city: 'Sofia',
            state: 'Sofia',
            postal_code: 1234,
            country: 'Bulgaria',
            phone: '088 41 555 27',
            invalid: 'this is invalid parameter'
          )
        }.to raise_error ArgumentError
      end

      it 'should with minimal parameters' do
        address = Address.new(
          name: 'Primary', street_address: 'Rambo Str.', street_address_addition: '', city: 'Sofia',
          state: 'Sofia', postal_code: 1234, country: 'Bulgaria', phone: '088 41 555 27'
        )

        expect( address.name ).to eq 'Primary'
        expect( address.street_address ).to eq 'Rambo Str.'
        expect( address.street_address_addition ).to be_empty
        expect( address.city ).to eq 'Sofia'
        expect( address.state ).to eq 'Sofia'
        expect( address.postal_code ).to be 1234
        expect( address.country ).to eq 'Bulgaria'
        expect( address.phone ).to eq '088 41 555 27'
      end

    end
  end
end
