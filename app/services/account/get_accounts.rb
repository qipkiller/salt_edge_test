module Account
  class GetAccounts < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      connection = @user.connections.active.first
      if connection
        res = SaltEdge::Client.instance.accounts(connection.remote_id)
        res.each do |a|
        end
        return res if res.response.code == 200
      end
      false
    end
  end
end
