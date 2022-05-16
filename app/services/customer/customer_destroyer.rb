module Customer
    class CustomerDestroyer < ApplicationService
      attr_reader :customer_id
  
      def initialize(customer_id)
        @customer_id = customer_id
      end
  
      def call
        res = SaltEdge::Client.instance.remove_customer(@customer_id)
        return false unless res.response.code == 200
  
        true
      end
    end
  end
  