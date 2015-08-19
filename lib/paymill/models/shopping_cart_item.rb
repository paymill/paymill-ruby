module Paymill
  class ShoppingCartItem
    attr_accessor :name, :amount, :quantity, :item_number, :url, :description

    def initialize( arguments = {} )
      arguments.each do |key, value|
        raise ArgumentError.new( "parameter #{key} is not allowed" ) unless ShoppingCartItem.instance_methods( false ).include? key
        instance_variable_set( "@#{key}", ( Integer( value ) rescue value ) )
      end
    end

  end
end
