module Paymill
  class Client < Base
    include Restful::Update
    include Restful::Delete

    attr_accessor :email, :description
    attr_reader :payments, :subscriptions

    protected
    def self.create_with?( incoming_arguments )
      return false if mandatory_arguments.select { |a| incoming_arguments.include? a }.size < mandatory_arguments.size
      allowed_arguments.size == ( allowed_arguments | incoming_arguments ).size
    end

    def self.allowed_arguments
      [:email, :description]
    end

    def self.mandatory_arguments
      []
    end

  end
end
