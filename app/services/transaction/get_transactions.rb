module Transaction
    class GetTransactions < ApplicationService
      def initialize(user, account_id)
        @user = user
        @account_id = account_id
      end
  
      def call
        connection = @user.connections.active.first
        if connection
          res = SaltEdge::Client.instance.transactions(connection.remote_id, @account_id)
          return res.data if res.response.code == 200
        end
        false
      end
    end
  end
  