module Transaction
    class GetPendingTransactions < ApplicationService
      def initialize(user, account_id)
        @user = user
        @account_id = account_id
      end
  
      def call
        connection = @user.connections.active.first
        if connection
          res = SaltEdge::Client.instance.pending_transactions(connection.remote_id, @account_id)
          return res if res.response.code == 200
        end
        false
      end
    end
  end
  