module SaltEdge
  class Client
    module Transaction
      def transactions(connection, account)
        get('/api/v5/transactions', { query: { connection_id: connection, account_id: account } })
      end
      
      def pending_transactions(connection, account)
        get('/api/v5/transactions/pending', { query: { connection_id: connection, account_id: account } })
      end
    end
  end
end
