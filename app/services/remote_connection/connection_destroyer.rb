module RemoteConnection
  class ConnectionDestroyer < ApplicationService
    attr_reader :user

    def initialize(user = nil)
      @user = user
    end

    def call
      if @user.connections.active.count > 0
        res = RemoteConnection::ConnectionDestroyerRemote.call(@user)
        return RemoteConnection::ConnectionDestroyerLocal.call(@user) if res.response.code == 200
      end
      false
    end
  end
end
