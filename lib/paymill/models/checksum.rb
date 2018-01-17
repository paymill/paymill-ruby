module Paymill
  class Checksum
    extend Restful::Create

    attr_reader :id, :created_at, :updated_at, :app_id, :action, :checksum, :data, :type, :items, :shipping_address

    def initialize( json )
      deserialize( json )
      parse_timestamps
    end

    protected
    def self.create_with?( incoming_arguments )
      return false if mandatory_arguments.select { |a| incoming_arguments.include? a }.size < mandatory_arguments.size
      allowed_arguments.size == ( allowed_arguments | incoming_arguments ).size
    end

    def self.allowed_arguments
      [
        :checksum_type, :amount, :currency, :return_url, :cancel_url, :description,
        :shipping_address, :billing_address, :items, :shipping_amount, :handling_amount, :client_id, :customer_email,
        :require_reusable_payment, :reusable_payment_description,
        :fee_amount, :fee_payment, :fee_currency, :app_id
      ]
    end

    def self.mandatory_arguments
      [:checksum_type, :amount, :currency, :return_url, :cancel_url]
    end

    # Parses UNIX timestamps and creates Time objects.
    def parse_timestamps
      @created_at &&= Time.at( @created_at )
      @updated_at &&= Time.at( @updated_at )
    end

    private
    def deserialize( json )
      json.each_pair do |key, value|
        instance_variable_set( "@#{key}", (Integer( value ) rescue value) )
      end
    end

  end
end
