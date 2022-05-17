module Account
  class GetAccounts < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      connection = @user.connections.active.first
      if connection
        res = SaltEdge::Client.instance.accounts(connection.remote_id)
        return res.data if res.response.code == 200
      end
      false
    end
  end
end
