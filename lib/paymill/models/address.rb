module Paymill
  class Address
    attr_accessor :name, :street_address, :street_address_addition, :city, :state, :postal_code, :country, :phone

    def initialize( arguments = {} )
      arguments.each do |key, value|
        raise ArgumentError.new( "parameter #{key} is not allowed" ) unless Address.instance_methods( false ).include? key
        instance_variable_set( "@#{key}", ( Integer( value ) rescue value ) )
      end
    end

  end
end
