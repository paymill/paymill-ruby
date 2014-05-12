module Paymill
  class Preauthorization < Base
    include Paymill::Operations::Delete

    attr_accessor :id, :amount, :status, :livemode, :payment, :currency, :client, :source

    def self.create(attributes)
      response = Paymill.request(:post, "preauthorizations", attributes)
      Transaction.new(response["data"])
    end
  end
end
