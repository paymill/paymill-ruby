module Paymill
  class Base
    extend Restful::All
    extend Restful::Find
    extend Restful::Create

    attr_reader :id, :created_at, :updated_at, :app_id

    def initialize( json )
      deserialize( json )
      parse_timestamps
    end

    protected
    def self.create_with?( incoming_arguments )
      return false if mandatory_arguments.select { |a| incoming_arguments.include? a }.size < mandatory_arguments.size
      allowed_arguments.size == ( allowed_arguments | incoming_arguments ).size
    end

    # Parses UNIX timestamps and creates Time objects.
    def parse_timestamps
      @created_at &&= Time.at( @created_at )
      @updated_at &&= Time.at( @updated_at )
    end

    private
    def deserialize( json )
      json.each_pair do |key, value|
        case value.class.name
        when 'Array'
          unless key[-1].eql? 's'
            instance_variable_set( "@#{key}s", value.map { |e| (e.is_a? String) ? e : objectize( key, e ) } )
          else
            instance_variable_set( "@#{key}", value.map { |e| (e.is_a? String) ? e : objectize( key, e ) } )
          end
        when 'Hash'
          instance_variable_set( "@#{key}", objectize( key, value ) )
        else
          instance_variable_set( "@#{key}", (Integer( value ) rescue value) )
        end
      end
    end

    # Converts the given 'hash' object into an instance of class with name stored in 'clazz' variable
    def objectize( clazz, hash )
      Module.const_get( "#{self.class.name.split( '::' ).first}::#{clazz.split('_').map(&:capitalize).join}" ).new( hash )
    end

  end
end
