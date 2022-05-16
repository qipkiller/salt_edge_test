module SaltEdge
  class Client
    module Customer
      # def customer(customer)
      #   get("/api/v5/customers/customers/#{customer}")
      # end

      def customers()
        get('/api/v5/customers')
      end

      def create_customer(options = {})
        post('/api/v5/customers', options)
      end

      def remove_customer(customer, options = {})
        delete("/api/v5/customers/#{customer}", options)
      end
    end
  end
end
