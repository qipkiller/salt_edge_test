module SaltEdge
  class Client
    module Connection
      # def connection(connection)
      #   get("/connections/#{connection}")
      # end

      def connections(customer_id)
        get('/api/v5/connections', { query: { customer_id: customer_id } })
      end

      def create_connection(options = {})
        post('/api/v5/connections', options)
      end

      # def update_connection(connection, options)
      #   put("/connections/#{connection}", options)
      # end

      # def refresh_connection(connection, options)
      #   put("/connections/#{connection}/refresh", options)
      # end

      # def reconect_connection(connection, options)
      #   put("/connections/#{connection}/reconnect", options)
      # end

      def remove_connection(connection, options = {})
        delete("/api/v5/connections/#{connection}", options)
      end
    end
  end
end
