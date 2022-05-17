module SaltEdge
  class Client
    module Account
      def accounts(connection)
        get('/api/v5/accounts', { query: { connection_id: connection } })
      end
    end
  end
end
